class ShipmentWorker
  include Sidekiq::Worker
  
  def perform(user_id, shipments)
    puts "Sending an email to user"
    UserMailer.product_shipment(user_id, shipments).deliver
  end
end