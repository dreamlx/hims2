class Api::InstitutionsController < Api::BaseController
  before_action :authenticate_user!
  def index
    @institutions = current_user.institutions.order(created_at: :desc)
  end

  def create
    return api_error(status: 422) if params[:institution].nil?
    @institution = current_user.institutions.build(institution_params)
    if params[:institution][:business_licenses]
      @institution.business_licenses = parse_image_data(params[:institution][:business_licenses]) 
    end
    if @institution.save
      render 'show', status: 201
    else
      return api_error(status: 422)
    end
  end

  def show
    @institution = current_user.institutions.find_by(id: params[:id])
    if @institution
    else
      return api_error(status: 422)
    end
  end

  def update
    return api_error(status: 422) if params[:institution].nil?

    @institution = current_user.institutions.find_by(id: params[:id])
    return api_error(status: 422) if @institution.nil?

    if params[:institution][:business_licenses]
      @institution.business_licenses = parse_image_data(params[:institution][:business_licenses]) 
    end

    if @institution.update(institution_params)
      render 'show'
    else
      return api_error(status: 422)
    end
  end

  private
    def institution_params
      params.require(:institution).permit(:name, :cell, :remark_name, :organ_reg, :remark)
    end
end