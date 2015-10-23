class MoneyReceiptsController < ApplicationController

  def index
    @money_receipts = MoneyReceipt.all
    respond_to do |format|
      header_string = 'attachment; filename=money_receipts' + DateTime.now.to_s(:number) + ".xlsx"
      format.xlsx{  response.headers['Content-Disposition'] = header_string}
    end
  end

  def create
    order = Order.find(params[:order_id])
    @money_receipt = order.money_receipts.build(money_receipt_params)
    @money_receipt.save
    redirect_to order
  end

  def update
    @money_receipt = MoneyReceipt.find(params[:id])
    @money_receipt.update(money_receipt_params)
    respond_to do |format|
      format.json { respond_with_bip(@money_receipt) }
    end
  end

  def destroy
    order = Order.find(params[:order_id])
    order.money_receipts.find(params[:id]).destroy
    redirect_to order
  end

  def confirm
    order = Order.find(params[:order_id])
    @money_receipt = order.money_receipts.find(params[:id])
    @money_receipt.confirm
    redirect_to order
  end

  def deny
    order = Order.find(params[:order_id])
    @money_receipt = order.money_receipts.find(params[:id])
    @money_receipt.deny
    redirect_to order
  end

  private
    def money_receipt_params
      params.require(:money_receipt).permit(:amount, :bank_charge, :date, :attach)
    end
end