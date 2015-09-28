class Api::OrdersController < Api::BaseController
  before_action :authenticate_user!
  def create
    return api_error(status: 422) if params[:order].nil?
    @order = current_user.orders.build(order_params)
    if params[:order][:other]
      @order.other = parse_image_data(params[:order][:other]) 
    end

    if params[:order][:investable_id]
      if params[:order][:investable_id].split(":")[1]
        @order.investable_id = params[:order][:investable_id].split(":")[1].to_i
      end
      if params[:order][:investable_id].start_with?("individual:")
        @order.investable_type = "Individual"
      elsif params[:order][:investable_id].start_with?("institution:")
        @order.investable_type = "Institution"
      end
    end
    return api_error(status: 422) if current_user.id != @order.investable.user_id
    if @order.save
      render 'show', status: 201
    else
      return api_error(status: 422)
    end
  ensure 
    clean_tempfile
  end

  def show
    @order = current_user.orders.find_by(id: params[:id])
    return api_error(status: 422) if @order.nil?
  end

  def update_infos
    @order = current_user.orders.find(params[:id])
    infos_params = params[:infos]
    infos_params.each do |key, value|
      if value.keys.first == "photo"
        Info.find(key).update_attribute(value.keys.first, parse_image_data(value.values.first))
      else
        Info.find(key).update_attribute(value.keys.first, value.values.first)
      end
    end
    # Info.update(infos_params.keys, infos_params.values)
    render 'show'
  ensure 
    clean_tempfile
  end


  private
    def order_params
      params.require(:order).permit(:product_id, :amount, :due_date, :mail_address, :remark)
    end
end