require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  def sign_in_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:random_user)
    sign_in @user
  end
  before(:each){ sign_in_user }
  let(:comment){
    product = create(:random_product, user_id: @user.id)
    comment = create(:random_comment, product_id: product.id, user_id: @user.id)
  }
  context "#create" do
    it "creates the comment and renders the product show page" do
      post :create, params: {product_id: comment.product.id, comment: {comment: comment.comment, product_id: comment.product.id}}
      expect(assigns(:comment)).not_to be_nil
      expect(response).to redirect_to(product_path(assigns(:product)))
    end
    it "redirect to product show page for invalid comment" do
      allow_any_instance_of(Comment).to receive(:save).and_return(false)
      post :create, params: {product_id: comment.product.id, comment: {comment: comment.comment, product_id: comment.product.id}}
      expect(response).to redirect_to(product_path(assigns(:product)))
    end
  end
  context "#edit" do
    it "finds the comment and renders the edit page" do 
      post :edit, params: {id: comment.id, product_id: comment.product.id}
      expect(assigns(:product)).not_to be_nil
      expect(assigns(:comment)).not_to be_nil
      expect(response).to render_template(:edit)
    end
  end
  context "#update" do
    it "updates the comment successfully" do
      patch :update, params: {id: comment.id, product_id: comment.product.id, comment: {comment: "an updated comment"}}
      comment.reload
      expect(comment.comment).to eq("an updated comment")
      expect(response).to redirect_to(product_path(assigns(:product)))
    end
    it "renders the edit page for invalid update" do
      allow_any_instance_of(Comment).to receive(:update).and_return(false)
      patch :update, params: {id: comment.id, product_id: comment.product.id, comment: {comment: "an updated comment"}}
      comment.reload
      expect(comment.comment).not_to eq("an updated comment")
      expect(response).to render_template(:edit)
    end
  end
  context "#destroy" do
    it "deletes the comment successfully" do
      comment
      expect{
        delete :destroy, params: {id: comment.id, product_id: comment.product.id}
      }.to change(Comment,:count).by(-1)
    end
  end
end
