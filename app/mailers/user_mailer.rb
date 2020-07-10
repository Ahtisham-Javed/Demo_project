class UserMailer < ApplicationMailer

  def product_creation(user,product)
    @user = user
    @product = product
    mail to: @user.email, subject: 'New product has been created against your account!' 
  end

  def product_shipment(user_id, shipments)
    @shipments = Shipment.find(shipments)
    user = User.find(user_id)
    mail to: user.email, subject: 'Successful Product Shipment'
  end
end