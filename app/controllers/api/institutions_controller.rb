class Api::InstitutionsController < Api::BaseController
  before_action :authenticate_user!, only: [:create, :index]
  def index
    @institutions = current_user.institutions.order(created_at: :desc)
  end

  def create
    @institution = current_user.institutions.build(institution_params)
    if params[:institution] && params[:institution][:business_licenses]
      @institution.business_licenses = parse_image_data(params[:institution][:business_licenses]) 
    end
    if @institution.save
      render 'show', status: 201
    else
      return api_error(status: 422)
    end
  end

  private
    def institution_params
      params.require(:institution).permit(:name, :cell, :remark_name, :organ_reg, :remark)
    end
end