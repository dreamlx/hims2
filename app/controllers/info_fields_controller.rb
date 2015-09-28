class InfoFieldsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    @info_field = product.info_fields.build(info_field_params)
    @info_field.save
    redirect_to product
  end

  def update
    @info_field = InfoField.find(params[:id])
    @info_field.update(info_field_params)
    respond_to do |format|
      format.json { respond_with_bip(@info_field) }
    end
  end

  def destroy
    product = Product.find(params[:product_id])
    product.info_fields.find(params[:id]).destroy
    redirect_to product
  end

  private
    def info_field_params
      params.require(:info_field).permit(
        :category, :field_name, :field_type)
    end
end