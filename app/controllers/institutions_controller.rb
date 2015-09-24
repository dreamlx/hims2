class InstitutionsController < ApplicationController
  def index
    @institutions = Institution.order(created_at: :desc)
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

  private
    def institution_params
      params.require(:institution).permit(
        :user_id, :name, :cell, :remark_name, :organ_reg,
        :business_licenses, :remark)
    end
end