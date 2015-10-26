class IndividualsController < ApplicationController
  def index
    @individuals = Individual.order(created_at: :desc)
    respond_to do |format|
      format.html
      header_string = 'attachment; filename=individuals' + DateTime.now.to_s(:number) + ".xlsx"
      format.xlsx{  response.headers['Content-Disposition'] = header_string}
    end
  end

  def new
    @individual = Individual.new
  end

  def create
    @individual = Individual.new(individual_params)
    if @individual.save
      redirect_to individuals_url
    else
      render 'new'
    end
  end

  def edit
    @individual = Individual.find(params[:id])
  end

  def update
    @individual = Individual.find(params[:id])
    if @individual.update(individual_params)
      redirect_to individuals_url
    else
      render 'edit'
    end
  end

  def destroy
    Individual.find(params[:id]).destroy
    redirect_to individuals_url
  end

  def confirm
    Individual.find(params[:id]).confirm
    redirect_to root_url
  end

  def deny
    Individual.find(params[:id]).deny
    redirect_to root_url
  end

  private
    def individual_params
      params.require(:individual).permit(
        :user_id, :name, :cell, :remark_name, :id_type,
        :id_no, :id_front, :id_back, :remark, :state)
    end
end