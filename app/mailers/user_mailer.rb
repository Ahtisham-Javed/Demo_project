class UserMailer < ApplicationMailer

  def product_creation
    @user = params[:user]
    @product = params[:product]
    mail to: @user.email, subject: 'New product has been created against your account!' 
  end
end