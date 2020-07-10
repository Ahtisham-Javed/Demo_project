class ShipmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cart = Cart.find_by_user_id(current_user.id)
    @shipments = Shipment.where(cart_id: @cart.id, status: false)
    # Status false indicates that products have been added to cart but order has not been placed
    # yet, and status true represents successfull shipments
  end

  def create
    @shipment = Shipment.new(shipment_params)
    if @shipment.save
      redirect_to products_path, notice: "Product has been added to cart"
    else
      redirect_to products_path, notice: "Product has not been added to cart"
    end
  end

  def edit
    @shipment = Shipment.find(params[:id])
  end

  def update
    @shipment = Shipment.find(params[:id])
    if @shipment.update(quantity: shipment_params[:quantity])
      redirect_to shipments_path, notice: "Quantity updated"
    else
      render 'edit', notice: "Unable to update the shipment"
    end
  end

  def destroy
    @shipment = Shipment.find(params[:id])
    @shipment.destroy!
    redirect_to shipments_path, notice: "Product has been removed from cart"
  end

  private

    def shipment_params
      params.require(:shipment).permit(:cart_id, :product_id, :quantity)
    end
end
