class UserMailer < ApplicationMailer

  def product_creation(user,product)
    @user = user
    @product = product
    mail to: @user.email, subject: 'New product has been created against your account!' 
  end
end