class Api::IndividualsController < Api::BaseController
  before_action :authenticate_user!, only: [:create, :index]
  def index
    @individuals = current_user.individuals.order(created_at: :desc)
  end

  def create
    @individual = current_user.individuals.build(indivdual_params)
    @individual.id_front = parse_image_data(params[:individual][:id_front]) if params[:individual] && params[:individual][:id_front]
    @individual.id_back = parse_image_data(params[:individual][:id_back]) if params[:individual] && params[:individual][:id_back]
    if @individual.save
      render 'show', status: 201
    else
      return api_error(status: 422)
    end
  end

  private
    def indivdual_params
      params.require(:individual).permit(
        :name, :cell, :remark_name, :id_type, :id_no,
        :remark)
    end
end