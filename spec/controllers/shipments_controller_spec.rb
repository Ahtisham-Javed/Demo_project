require 'rails_helper'

RSpec.describe ShipmentsController, type: :controller do
  def sign_in_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = create(:random_user)
    sign_in @user
  end
  before(:each){ sign_in_user }
  let(:shipment){
    user = create(:random_user)
    product = create(:random_product, user_id: user.id)
    shipment = create(:random_shipment, cart_id: @user.cart.id, product_id: product.id, status: false)
  }
  context "#index" do
    it "finds the cart for current user" do
      get :index
      expect(assigns(:cart)).not_to be_nil
    end
    before{shipment}
    it "finds the shipments for current user and renders the index page" do
      get :index
      expect(assigns(:shipments)).not_to be_nil
      expect(response).to render_template(:index)
    end
  end
  context "#create" do
    before{
      user = create(:random_user)
      product = create(:random_product, user_id: user.id)
    }
    it "creates new shipment and redirects to products index page" do
      post :create, params: {shipment: {cart_id: @user.cart.id, product_id: Product.first.id, quantity: 30}}
      expect(assigns(:shipment)).not_to be_nil
      expect(response).to redirect_to(products_path)
    end
    it "renders the products index page for invalid shipment" do
      allow_any_instance_of(Shipment).to receive(:save).and_return(false)
      post :create, params: {shipment: {cart_id: 1, product_id: 1, quantity: 30}}
      expect(response).to redirect_to(products_path)
    end
  end
  context "#edit" do
    before{shipment}
    it "finds the right shipment and renders the edit page" do
      get :edit, params: {id: Shipment.first.id}
      expect(assigns(:shipment)).not_to be_nil
      expect(response).to render_template(:edit)
    end
  end
  context "#update" do
    before(:each){shipment}
    it "updates the shipment and redirects successfully" do
      patch :update, params: {id: Shipment.first.id, shipment: {quantity: 1}}
      expect(response).to redirect_to(shipments_path)    
    end
    it "renders the edit page for invalid update" do
      allow_any_instance_of(Shipment).to receive(:update).and_return(false)
      patch :update, params: {id: Shipment.first.id, shipment: {quantity: 1}}
      expect(response).to render_template(:edit)    
    end
  end
  context "#destroy" do
    before{shipment}
    it "deletes the shipment successfully" do
      expect{
        delete :destroy, params: {id: Shipment.first.id}
      }.to change(Shipment,:count).by(-1)
    end
  end
end
