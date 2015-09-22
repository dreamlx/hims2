class Api::ProductsController < Api::BaseController
  def index
    fund = Fund.find(params[:fund_id])
    @products = fund.products.order(created_at: :desc)
  end

  def show
    @product = Product.find(params[:id])
  end
end