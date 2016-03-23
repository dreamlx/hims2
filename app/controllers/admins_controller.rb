class AdminsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @admins = Admin.all
    # @admins_grid = initialize_grid(Admin)
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to admins_url
    else
      render 'new'
    end
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def edit_role
    @admin = Admin.find(params[:id])
  end

  def role_update
    @admin = Admin.find(params[:id])
    if @admin.update_attribute(:roles_mask, params[:roles])
      redirect_to admins_url
    else
      render 'edit'
    end
  end

  def update
    @admin = Admin.find(params[:id])

    if params[:admin][:roles]
      if @admin.update_attribute(:roles_mask, params[:admin][:roles])
        redirect_to admins_url
      else
        render 'edit'
      end
    else
      if @admin.update(admin_params)
        redirect_to admins_url
      else
        render 'edit'
      end
    end
  end

  def destroy
    Admin.find(params[:id]).destroy
    redirect_to admins_url
  end

  private
   def admin_params
    params.require(:admin).permit(
      :name, :password, :password_confirmation, :roles_mask, :roles)
   end
end
