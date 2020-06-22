class ShipmentsController < ApplicationController

  before_action :authenticate_user!

  def edit
    @shipment = Shipment.find(params[:id])
  end

  def update
    @shipment = Shipment.find(params[:id])
    if @shipment.update(quantity: shipment_params[:quantity])
      redirect_to shipments_path, notice: "Quantity updated"
    else
      render 'edit'
    end
  end

  def index
    @cart = Cart.find_by_user_id(current_user.id)
    @shipments = Shipment.where(cart_id: @cart.id)
  end

  def create
    @shipment = Shipment.new(shipment_params)
    if @shipment.save
      redirect_to products_path(params[:product_id]), notice: "Product has been added to cart"
    else
      render products_path(params[:product_id])
    end
  end

  def destroy
    @shipment = Shipment.find(params[:id])
    @shipment.destroy
    redirect_to shipments_path, notice: "Product has been removed from cart"
  end

  def checkout_form

  end

  private
    def shipment_params
      params.require(:shipment).permit(:cart_id, :product_id, :quantity)
    end

end
