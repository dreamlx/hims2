class AttachesController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    @attach = product.attaches.build(attach_params)
    @attach.save
    redirect_to product
  end

  def update
    @attach = Attach.find(params[:id])
    @attach.update(attach_params)
    respond_to do |format|
      format.json { respond_with_bip(@attach) }
    end
  end

  def destroy
    product = Product.find(params[:product_id])
    product.attaches.find(params[:id]).destroy
    redirect_to product
  end

  private
    def attach_params
      params.require(:attach).permit(
        :title, :attach, :category)
    end
end