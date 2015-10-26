class PicturesController < ApplicationController
  def create
    order = Order.find(params[:order_id])
    @picture = order.pictures.build(picture_params)
    @picture.save
    redirect_to order
  end

  def update
    @picture = Picture.find(params[:id])
    @picture.update(picture_params)
    respond_to do |format|
      format.json { respond_with_bip(@picture) }
    end
  end

  def destroy
    order = Order.find(params[:order_id])
    order.pictures.find(params[:id]).destroy
    redirect_to order
  end

  def confirm
    order = Order.find(params[:order_id])
    @picture = order.pictures.find(params[:id])
    @picture.confirm
    redirect_to order
  end

  def deny
    order = Order.find(params[:order_id])
    @picture = order.pictures.find(params[:id])
    @picture.deny
    redirect_to order
  end

  private
    def picture_params
      params.require(:picture).permit(:title, :pic, :state)
    end
end