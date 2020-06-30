require 'rails_helper'

RSpec.describe Cart, type: :model do
  context "validation tests" do
    let!(:cart) {build(:random_cart)}
    it "ensures user presence" do
      expect {
        cart.user_id = nil
        cart.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures foreign key constraint for invalid user" do
      expect {
        cart.user_id = 999
        cart.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end 
  end
end
