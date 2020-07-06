require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:product){
    user = create(:random_user,email: "railstesting32@gmail.com")
    create(:random_product,user_id: user.id)
  }
  let(:mail){UserMailer.product_creation(product.user,product)}
  it "should send new product creation notification" do
    expect(mail.subject).to eq("New product has been created against your account!")
    expect(mail.from).to eq(["#{Rails.application.credentials.dig(:gmail_username)}"])
    expect{
      UserMailer.product_creation(product.user,product).deliver_now
    }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
