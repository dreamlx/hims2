class Api::MoneyReceiptsController < Api::BaseController
  before_action :authenticate_user!, only: [:create]
  def create
    order = current_user.orders.find_by(id: params[:order_id])
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

  private
    def money_receipt_params
      params.require(:money_receipt).permit(:amount, :date)
    end
end