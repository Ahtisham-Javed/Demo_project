require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:product){
    user = create(:user,email: "railstesting32@gmail.com")
    create(:product,user_id: user.id)
  }
  let(:mail){UserMailer.product_creation(product.user,product)}
  it "should send new product creation notification" do
    expect(mail.subject).to eq("New product has been created against your account!")
    expect(mail.from).to eq(["railstesting32@gmail.com"])
    expect(mail.body.encoded).to include("#{product.title}")
    expect(mail.body.encoded).to include("#{product.price}")
    expect(mail.body.encoded).to include("#{product.serial_number}")
    expect(mail.body.encoded).to include("#{product.description}")
    expect{
      UserMailer.product_creation(product.user,product).deliver_now
    }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
