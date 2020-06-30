require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "validation tests" do
    let!(:comment) {build(:random_comment)}
    it "ensures comment presence" do
      expect {
        comment.comment = nil
        comment.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures user presence" do
      expect {
        comment.user_id = nil
        comment.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures product presence" do
      expect {
        comment.product_id = nil
        comment.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures foreign key constraint for invalid user" do
      expect {
        comment.user_id = 9999
        comment.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures foreign key constraint for invalid product" do
      expect {
        comment.product_id = 9999
        comment.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
