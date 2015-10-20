require 'rest_client'
class Api::ProductsController < Api::BaseController
  before_action :authenticate_user!, only: [:my, :ordered]
  def index
    fund = Fund.find(params[:fund_id])
    @products = fund.products.order(created_at: :desc)
  end

  def show
    @product = Product.find(params[:id])
  end

  def my
    orders = current_user.orders
    @products = Product.joins(:orders).where(orders: {id: orders.ids}).uniq
    @user_id = current_user.id
  end

  def ordered
    # orders = current_user.orders
    # products = Product.joins(:orders).where(orders: {id: orders.ids})
    @product = Product.find_by(id: params[:id])
    @notices = @product.attaches.where(category: "基金公告")
    @reports = @product.attaches.where(category: "投资报告")
  end

  def send_mail
    email = params[:email]
    instruction_url = Product.find(params[:id]).instruction.url
    if email && instruction_url
      vars = JSON.dump({"to" => [email], "sub" => { "%url%" => ["<a href=#{instruction_url}>链接</a>"]} })
      response = RestClient.post "http://sendcloud.sohu.com/webapi/mail.send_template.json",
        :api_user => Rails.application.secrets.send_mail_user, # 使用api_user和api_key进行验证
        :api_key => Rails.application.secrets.send_mail_password,
        :from => Rails.application.secrets.from_email,
        :fromname => "hehui",
        :substitution_vars => vars,
        :template_invoke_name => 'pro_ins',
        :subject => "来自禾晖的理财产品说明",
        :resp_email_id => 'true'
      render json: response
    else
      render json: {message: "failed"}, status: 422
    end
  end
end