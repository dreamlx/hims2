class Api::UsersController < Api::BaseController
  before_action :authenticate_user!, only: [:all_investors]
  def create
    return api_error(status: 422) if params[:user].nil?

    # verify the cell code, return if no code or not match
    cell_code = CellCode.find_by(cell: params[:user][:cell])
    unless cell_code && cell_code.code && (cell_code.code == params[:user][:code])
      return api_error(status: 422)
    end

    @user = User.new(user_params)
    if @user.save
      render 'show', status: 201
    else
      return api_error(status: 422)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(name: params[:user][:name], email: params[:user][:email])
      render 'show'
    else
      return api_error(status: 422)
    end
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
    render json: @investors
  end

  private
    def user_params
      params.require(:user).permit(:open_id, :cell)
    end
end
