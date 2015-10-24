class Api::MoneyReceiptsController < Api::BaseController
  before_action :authenticate_user!
  def create
    order = current_user.user_orders.find_by(id: params[:order_id])
    @money_receipt = order.money_receipts.build(money_receipt_params)
    @money_receipt.attach = parse_image_data(params[:money_receipt][:attach]) if params[:money_receipt][:attach]
    if @money_receipt.save
      render 'show', status: 201
    else
      return api_error(status: 422)
    end
  ensure 
    clean_tempfile
  end

  def destroy
    order = current_user.user_orders.find_by(id: params[:order_id])
    money_receipt = order.money_receipts.find_by(id: params[:id])
    if money_receipt && money_receipt.state != '已确认'
      money_receipt.destroy
      render json: {}, status: 200
    else
      return api_error(status: 422)
    end
  end

  private
    def money_receipt_params
      params.require(:money_receipt).permit(:amount, :date)
    end
end