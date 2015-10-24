class OrdersController < ApplicationController
  def index
    @orders = Order.order(created_at: :desc)
    respond_to do |format|
      format.html
      header_string = 'attachment; filename=orders' + DateTime.now.to_s(:number) + ".xlsx"
      format.xlsx{  response.headers['Content-Disposition'] = header_string}
    end
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.investable_id = params[:order][:investable_id].split(":")[1].to_i
    if params[:order][:investable_id].start_with?("个人:")
      @order.investable_type = "Individual"
    elsif params[:order][:investable_id].start_with?("机构:")
      @order.investable_type = "Institution"
    elsif params[:order][:investable_id].start_with?("理财师:")
        @order.investable_type = "User"
    end
    if @order.save
      redirect_to orders_url
    else
      render 'new'
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      @order.investable_id = params[:order][:investable_id].split(":")[1].to_i
      if params[:order][:investable_id].start_with?("个人:")
        @order.investable_type = "Individual"
      elsif params[:order][:investable_id].start_with?("机构:")
        @order.investable_type = "Institution"
      end
      @order.save
      redirect_to orders_url
    else
      render 'edit'
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def destroy
    Order.find(params[:id]).destroy
    redirect_to orders_url
  end

  def update_infos
    @order = Order.find(params[:id])
    if @order.investable_type == "Individual" || (@order.investable_type == "User" && @order.investable.id_type == "个人")
      @order.product.individual_fields.each do |field|
        @order.infos.find_or_create_by(
          category: field.category,
          field_name: field.field_name,
          field_type: field.field_type)
      end
    elsif @order.investable_type == "Institution" || (@order.investable_type == "User" && @order.investable.id_type == "机构")
      @order.product.institution_fields.each do |field|
        @order.infos.find_or_create_by(
          category: field.category,
          field_name: field.field_name,
          field_type: field.field_type)
      end
    end
    redirect_to @order
  end

  private
    def order_params
      params.require(:order).permit(:product_id, :amount, :due_date, :mail_address, :other, :remark, :state, :deliver)
    end
end