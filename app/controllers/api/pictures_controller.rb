class Api::PicturesController < Api::BaseController
  before_action :authenticate_user!
  def create
    order = current_user.user_orders.find_by(id: params[:order_id])
    @picture = order.pictures.build(picture_params)
    @picture.pic = parse_image_data(params[:picture][:pic]) if params[:picture][:pic]
    if @picture.save
      render 'show', status: 201
    else
      return api_error(status: 422)
    end
  ensure 
    clean_tempfile
  end

  def destroy
    order = current_user.user_orders.find_by(id: params[:order_id])
    picture = order.pictures.find_by(id: params[:id])
    if picture && picture.state != '已确认'
      picture.destroy
      render json: {}, status: 200
    else
      return api_error(status: 422)
    end
  end

  private
    def picture_params
      params.require(:picture).permit(:title, :pic)
    end
end