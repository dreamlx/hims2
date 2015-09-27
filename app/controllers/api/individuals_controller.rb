class Api::IndividualsController < Api::BaseController
  before_action :authenticate_user!
  def index
    @individuals = current_user.individuals.order(created_at: :desc)
  end

  def create
    return api_error(status: 422) if params[:individual].nil?
    @individual = current_user.individuals.build(indivdual_params)
    @individual.id_front = parse_image_data(params[:individual][:id_front]) if params[:individual][:id_front]
    @individual.id_back = parse_image_data(params[:individual][:id_back]) if params[:individual][:id_back]
    if @individual.save
      render 'show', status: 201
    else
      return api_error(status: 422)
    end
  end

  def show
    @individual = current_user.individuals.find_by(id: params[:id])
    return api_error(status: 422) if @individual.nil?
  end

  def update
    return api_error(status: 422) if params[:individual].nil?

    @individual = current_user.individuals.find_by(id: params[:id])
    return api_error(status: 422) if @individual.nil?

    @individual.id_front = parse_image_data(params[:individual][:id_front]) if params[:individual][:id_front]
    @individual.id_back = parse_image_data(params[:individual][:id_back]) if params[:individual][:id_back]
    
    if @individual.update(indivdual_params)
      render 'show'
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