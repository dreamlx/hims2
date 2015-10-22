class ProductsController < ApplicationController
  def index
    @products = Product.order(created_at: :desc)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_url
    else
      render 'edit'
    end
  end

  def destroy
    Product.find(params[:id]).destroy
    redirect_to products_url
  end

  private
    def product_params
      params.require(:product).permit(
        :fund_id, :name, :desc, :title1, :content1,
        :title2, :content2, :title3, 
        :content3, :progress_bar, :label, :abbr,
        :currency, :amount, :period, :paid,
        :sales_period, :block_period, :redeem,
        :entity, :adviser, :trustee, :reg_organ,
        :website, :agency, :regulatory_filing,
        :legal_consultant, :audit, :starting_point,
        :account, :progress, :direction, :risk_control,
        :instruction, :agreement, :title4, :content4,
        :title5, :content5,:title6, :content6,:title7, 
        :content7, :remove_instruction, 
        :remove_agreement, :rate)
    end
end