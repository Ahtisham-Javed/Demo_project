require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { build(:random_user) }
  context 'validation tests' do
    it 'ensures name presence' do
      expect{
        user.name = nil
        user.save!  
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it 'ensures address presence' do
      expect { 
        user.address = nil
        user.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  context "callback tests" do
    it "ensures that user's cart has also been created" do
      my_user = user.save!
      cart = Cart.find_by_user_id(user.id)
      expect(cart).to be_instance_of Cart
    end
  end
end