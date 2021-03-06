class FundsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @funds = Fund.order(created_at: :desc)
    @funds_grid = initialize_grid(Fund)
  end

  def new
    @fund = Fund.new
  end

  def create
    @fund = Fund.new(fund_params)
    if @fund.save
      redirect_to funds_url
    else
      render 'new'
    end
  end

  def edit
    @fund = Fund.find(params[:id])
  end

  def update
    @fund = Fund.find(params[:id])
    if @fund.update(fund_params)
      redirect_to funds_url
    else
      render 'edit'
    end
  end

  def destroy
    Fund.find(params[:id]).destroy
    redirect_to funds_url
  end

  private
    def fund_params
      params.require(:fund).permit(
        :name, :desc, :title1, :content1,
        :title2, :content2, :title3,
        :content3, :progress_bar, :label, :currency)
    end
end
