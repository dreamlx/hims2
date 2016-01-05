class InstitutionsController < ApplicationController
  def index
    @institutions = Institution.order(created_at: :desc)
    @institutions_grid = initialize_grid(Institution)   
    respond_to do |format|
      format.html
      header_string = 'attachment; filename=institutions' + DateTime.now.to_s(:number) + ".xlsx"
      format.xlsx{  response.headers['Content-Disposition'] = header_string}
    end
  end

  def new
    @institution = Institution.new
  end

  def create
    @institution = Institution.new(institution_params)
    if @institution.save
      redirect_to institutions_url
    else
      render 'new'
    end
  end

  def edit
    @institution = Institution.find(params[:id])
  end

  def update
    @institution = Institution.find(params[:id])
    if @institution.update(institution_params)
      redirect_to institutions_url
    else
      render 'edit'
    end
  end

  def destroy
    Institution.find(params[:id]).destroy
    redirect_to institutions_url
  end

  def confirm
    Institution.find(params[:id]).confirm
    redirect_to root_url
  end

  def deny
    Institution.find(params[:id]).deny
    redirect_to root_url
  end

  private
    def institution_params
      params.require(:institution).permit(
        :user_id, :name, :cell, :remark_name, :organ_reg,
        :business_licenses, :remark, :state)
    end
end
