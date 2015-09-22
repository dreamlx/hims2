class Api::FundsController < Api::BaseController
  def index
    @funds = Fund.order(created_at: :desc)
  end
end