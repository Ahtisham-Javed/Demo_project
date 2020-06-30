require 'rails_helper'

RSpec.describe Cart, type: :model do
  context "validation tests" do
    it "ensures user presence" do
      expect {
        Cart.create!()
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures foreign key constraint for invalid user" do
      expect {
        Cart.create!(user_id: 999)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end 
  end
end
