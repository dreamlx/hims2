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
    investors_ids = Individual.where(id_no: params[:number]).ids + Institution.where(organ_reg: params[:number]).ids
    @order = Order.where(investable_id: investors_ids).find_by(id: params[:id]) if @order.nil?
    return api_error(status: 422) if @order.nil?
  end

  def update
    @order = current_user.orders.find_by(id: params[:id])
    
    if params[:order] && @order.update(deliver: params[:order][:deliver], remark: params[:order][:remark])
      render 'show'
    else
     return api_error(status: 422) 
    end
  end

  def destroy
    order = current_user.orders.find_by(id: params[:id])
    if order
      order.destroy
      render json: {}, status: 200
    else
      return api_error(status: 422)
    end
  end

  def update_infos
    @order = current_user.orders.find(params[:id])
    infos_params = params[:infos]
    infos_params.each do |key, value|
      info = Info.find(key)
      if value.keys.first == "photo"
        info.update("#{value.keys.first}": parse_image_data(value.values.first))
      else
        info.update("#{value.keys.first}": value.values.first)
      end
      info.submit
    end
    # Info.update(infos_params.keys, infos_params.values)
    render 'show'
  ensure 
    clean_tempfile
  end

  def by_state
    @booked = current_user.orders.where(state: "已预约")
    @completed = current_user.orders.where(state: "已报单")
    @valued = current_user.orders.where(state: "已起息")
  end

  def by_product
    orders = current_user.orders
    @products = Product.joins(:orders).where(orders: {id: orders.ids}).uniq
    @user_id = current_user.id
    render 'api/products/my'
  end

  def by_number
    return api_error(status: 422) if current_user.card_no != params[:number]
    investors_ids = Individual.where(id_no: params[:number]).ids + Institution.where(organ_reg: params[:number]).ids
    @orders = Order.where(investable_id: investors_ids)
  end

  private
    def order_params
      params.require(:order).permit(:product_id, :amount, :due_date, :mail_address, :remark)
    end
end