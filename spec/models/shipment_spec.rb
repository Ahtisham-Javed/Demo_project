require 'rails_helper'

RSpec.describe Shipment, type: :model do
  context "validation tests" do
    let!(:shipment) {build(:random_shipment)}
    it "ensures product presence" do
      expect {
        shipment.product_id = nil
        shipment.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures cart presence" do
      expect {
        shipment.cart_id = nil
        shipment.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures quantity presence" do
      expect {
        shipment.quantity = nil
        shipment.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures quantity to be integer" do
      expect {
        shipment.quantity = "temporary"
        shipment.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures foreign key constraint for invalid cart" do
      expect {
        shipment.cart_id = 9999
        shipment.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures foreign key constraint for invalid product" do
      expect {
        shipment.product_id = 9999
        shipment.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
