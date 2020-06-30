require 'rails_helper'

RSpec.describe Product, type: :model do
  let!(:product) {build(:random_product)}
  context "validation tests" do
    it "ensures title presence" do
      expect{
        product.title = nil
        product.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures price presence" do
      expect{
        product.price = nil
        product.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures price to be integer" do
      expect{
        product.price = "temporary"
        product.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures user presence" do
      expect{
        product.user_id = nil
        product.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures foreign key constraint for invalid user " do
      expect{
        product.user_id = 999
        product.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  context "callback tests" do
    it "ensures serial_number generation" do
      user = User.create(name: "temp", address: "lahore", email: "temp@gmail.com", password: "temppp")
      product.user_id = user.id
      product.save!
      expect(product.serial_number).not_to be_nil
    end
  end
end