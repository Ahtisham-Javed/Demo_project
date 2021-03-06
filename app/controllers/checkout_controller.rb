class CheckoutController < ApplicationController
  def create
    shipments = Shipment.find(params[:shipments])
    if shipments.nil?
      redirect_to shipments_path and return
    end

    cart_id = shipments[0].cart_id.to_s
    total = 0
    shipments.each do |shipment|
      total += (shipment.quantity * shipment.product.price)
    end
    discounts = { 'DEVSINC': 0.3, 'PAKARMY': 0.5 }
    if (params[:coupon] != "" && !discounts[params[:coupon].to_sym].nil?)
      total -= (total * discounts[params[:coupon].to_sym])
      total = total.round
    end
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        name: "Happy Shopping",
        description: "cart_id: " + cart_id,
        currency: 'usd',
        amount: total * 100,
        quantity: 1
      }],
      mode: 'payment',
      success_url: checkout_success_url + '?cart_id= ' + cart_id,
      cancel_url: checkout_cancel_url
    })
    
    respond_to do |format|
      format.js { render 'create.js.erb' }
    end
  end

  def success
    Shipment.where(cart_id: params[:cart_id]).update(status: true)
    shipments = Shipment.where(cart_id: params[:cart_id], status: true, updated_at: 5.minutes.ago..Time.now).map(&:id)
    ShipmentWorker.perform_in(24.hours, current_user.id, shipments)
    redirect_to products_path, notice: 'Your order has been placed successfully'
  end

  def cancel
    redirect_to shipments_path, notice: 'Sorry, Unable to place order'
  end
end
