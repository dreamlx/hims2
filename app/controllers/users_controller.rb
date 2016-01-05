class UsersController < ApplicationController
  def index
    @users = User.all
    @users_grid = initialize_grid(User)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_url
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url
  end

  def confirm
    User.find(params[:id]).confirm
    redirect_to root_url
  end

  def deny
    User.find(params[:id]).deny
    redirect_to root_url
  end

  private
   def user_params
    params.require(:user).permit(
      :open_id, :cell, :name, :email, :id_type, :nickname, :gender,
      :address, :card_type, :card_no, :card_front, :card_back,
      :remark, :number, :state)
   end
end
