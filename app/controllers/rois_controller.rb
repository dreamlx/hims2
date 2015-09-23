class RoisController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    @roi = product.rois.build(roi_params)
    @roi.save
    redirect_to product
  end

  def update
    @roi = Roi.find(params[:id])
    @roi.update(roi_params)
    respond_to do |format|
      format.json { respond_with_bip(@roi) }
    end
  end

  def destroy
    product = Product.find(params[:product_id])
    product.rois.find(params[:id]).destroy
    redirect_to product
  end

  private
    def roi_params
      params.require(:roi).permit(
        :range, :profit)
    end
end