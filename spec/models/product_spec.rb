require 'rails_helper'

RSpec.describe Product, type: :model do
  context "validation tests" do
    it "ensures title presence" do
      expect{
        Product.create!(description: "a product", price: 678, user_id: 1)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures price presence" do
      expect{
        Product.create!(title: "temporary", description: "a product", user_id: 1)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures price to be integer" do
      expect{
        Product.create!(title: "temporary", price: "temporary", user_id: 1)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures user presence" do
      expect{
        Product.create!(title: "temporary", description: "a product", price: 678)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures foreign key constraint for invalid user " do
      expect{
        Product.create!(title: "temporary", price: 678, user_id: 999)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  context "callback tests" do
    it "ensures serial_number generation" do
      user = User.create!(name: "temp", address: "phase 5",email: "temp@gmail.com", password: "temppp")
      product = Product.create!(title: "temporary", description: "a product", price: "123", user_id: user.id)
      expect(product.serial_number).not_to be_nil
    end
  end
end