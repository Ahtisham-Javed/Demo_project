require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "validation tests" do
    it "ensures comment presence" do
      expect {
        Comment.create!(user_id: 1, product_id: 1)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures user presence" do
      expect {
        Comment.create!(comment: "a comment", product_id: 1)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures product presence" do
      expect {
        Comment.create!(user_id: 1, comment: "a comment")
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures foreign key constraint for invalid user" do
      expect {
        Comment.create!(comment: "a comment", user_id: 999, product_id: 1)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it "ensures foreign key constraint for invalid product" do
      expect {
        Comment.create!(comment: "a comment", user_id: 1, product_id: 999)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
