require 'rails_helper'

RSpec.describe Shipment, type: :model do
  context "validation tests" do
    it "ensures product presence" do
      expect {
        Shipment.create!(cart_id: 1, quantity: 1)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures user presence" do
      expect {
        Shipment.create!(product_id: 1, quantity: 1)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures quantity presence" do
      expect {
        Shipment.create!(cart_id: 1, product_id: 1)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures quantity to be integer" do
      expect {
        Shipment.create!(cart_id: 1, product_id: 1, quantity: "temporary")
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures foreign key constraint for invalid cart" do
      expect {
        Shipment.create!(cart_id: 999, product_id: 1, quantity: 1)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures foreign key constraint for invalid product" do
      expect {
        Shipment.create!(cart_id: 1, product_id: 999, quantity: 1)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
