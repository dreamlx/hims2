class InfosController < ApplicationController
  def confirm
    order = Order.find(params[:order_id])
    order.infos.find(params[:id]).confirm
    redirect_to order
  end

  def deny
    order = Order.find(params[:order_id])
    order.infos.find(params[:id]).deny
    redirect_to order
  end
  def destroy
    order = Order.find(params[:order_id])
    order.infos.find(params[:id]).destroy
    redirect_to order
  end
end