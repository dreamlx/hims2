class Api::UsersController < Api::BaseController
  before_action :authenticate_user!, only: [:all_investors, :update, :show]
  def create
    return api_error(status: 422) if params[:user].nil?

    # verify the cell code, return if no code or not match
    cell_code = CellCode.find_by(cell: params[:user][:cell])
    unless cell_code && cell_code.code && (cell_code.code == params[:user][:code]) && ((cell_code.created_at + 1.hour) > DateTime.now )
      return api_error(status: 422)
    end

    @user = User.find_by(cell: params[:user][:cell])
    if @user
      @user.update_attribute(:open_id, params[:user][:open_id])
    else
      @user = User.new(open_id: params[:user][:open_id], cell: params[:user][:cell])
    end
    if @user.save
      render 'show', status: 201
    else
      return api_error(status: 422)
    end
  end

  def show
    @user = current_user
  end

  def update
    return api_error(status: 422) if params[:user].nil?
    @user = User.find_by(id: params[:id])
    return api_error(status: 422) if @user.nil?

    @user.card_front = parse_image_data(params[:user][:card_front]) if params[:user][:card_front]
    @user.card_back = parse_image_data(params[:user][:card_back]) if params[:user][:card_back]

    if @user.update(user_params)
      @user.submit
      render 'show'
    else
      return api_error(status: 422)
    end
  ensure
    clean_tempfile
  end

  def send_code
    # create a random code, not unique
    code = rand(100000..999999)
    cell = params[:cell]
    # if succeed to send code, save the cell and code in table of cell_codes
    if User.send_code(cell, code)
      CellCode.where(cell: cell).delete_all
      CellCode.create(cell: cell, code: code)
      render json: {}, status: 200
    else
      return api_error(status: 422)
    end
  end

  def all_investors
    @investors = current_user.individuals.map {|e| Hash["individual:#{e.id}" => ("[个人]" + e.name)]}
    current_user.institutions.map {|e| @investors << Hash["institution:#{e.id}" => ("[机构]" + e.name)]}
    @investors << Hash["user:#{current_user.id}" => ("[理财师]#{current_user.name}")]
    render json: @investors
  end

  def receive_code
    uri = URI("https://api.weixin.qq.com/sns/oauth2/access_token?appid=#{ENV["WECHAT_APP_ID"]}&secret=#{ENV["WECHAT_APP_SECRET"]}&code=#{params[:code]}&grant_type=authorization_code")
    res = Net::HTTP.get_response(uri)
    json =  JSON.parse(res.body.gsub(/[\u0000-\u001f]+/, ''))
    if json["openid"].blank?
      render json: {}, status: 200
    else
      open_id = json["openid"]
      user = User.find_by(open_id: open_id)
      if user
        if params[:state] == "main"
          redirect_to "http://wx.hehuifunds.com/menu.html#invest-list?open_id=#{open_id}&user_id=#{user.id}"
        elsif params[:state] == "my"
          redirect_to "http://wx.hehuifunds.com/menu.html#mine-invest?open_id=#{open_id}&user_id=#{user.id}"
        end
      else
        redirect_to "http://wx.hehuifunds.com/register.html?open_id=#{open_id}"
      end
    end
  end

  def risk_evaluation
    if params[:form]
      # byebug
      Rails.logger.debug "sheet #{params[:entry][:serial_number]}"
      Rails.logger.debug "sheet #{params[:entry][:field_1]}"
    end
    render json: {}, status: 200
  end

  private
    def user_params
      params.require(:user).permit(
        :name, :email, :id_type, :nickname,
        :gender, :address, :card_type, :card_no, :remark)
    end
end
