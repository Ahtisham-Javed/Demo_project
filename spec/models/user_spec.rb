require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures name presence' do
      expect {
        User.create!(email: "temp@gmail.com", password: "temppp", address: "phase 5") 
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it 'ensures address presence' do
      expect { 
        User.create!(email: "temp@gmail.com", password: "temppp", name: "tempoo")
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  context "callback tests" do
    it "ensures that user's cart has also been created" do
      user = User.create!(email: "temp@gmail.com", password: "temppp", name: "tempoo", address: "phase 5")
      cart = Cart.find_by_user_id(user.id)
      expect(cart).to be_instance_of Cart
    end
  end
end