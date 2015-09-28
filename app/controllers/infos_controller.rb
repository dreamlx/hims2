class InfosController < ApplicationController
  def destroy
    order = Order.find(params[:order_id])
    order.infos.find(params[:id]).destroy
    redirect_to order
  end
end