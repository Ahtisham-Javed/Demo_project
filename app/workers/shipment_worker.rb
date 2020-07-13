class ShipmentWorker
  include Sidekiq::Worker
  
  def perform(user_id, shipments)
    UserMailer.product_shipment(user_id, shipments).deliver
  end
end