require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  def sign_in_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = create(:random_user)
    sign_in user
  end
  let(:static_product){
    user = create(:user)
    static_product = create(:product, user_id: user.id)   
  }
  let(:product){
    user = create(:random_user)
    product = create(:random_product, user_id: user.id)
  }
  context "#index" do
    before{
      user = create(:random_user)
      product1 = create(:random_product, user_id: user.id)
      product2 = create(:random_product, user_id: user.id)
      controller.instance_variable_set(:@products, [product1,product2,static_product])
    }
    it "renders the index template for searched products", :sphinx => true do
      ThinkingSphinx::Test.run do
        get :index, params: {search: static_product.title}
        expect(assigns(:products)).not_to be_nil
        expect(assigns(:products)).to match_array([static_product])
        expect(response).to render_template(:index)
        ThinkingSphinx::Deltas.resume!
      end
    end
  end
  context "#new" do
    it "renders new template" do
      sign_in_user
      get :new
      expect(assigns(:product)).to be_instance_of Product
      expect(response).to render_template(:new)
    end
  end
  context "#create" do
    it "saves the product successfully and redirect to show page" do
      sign_in_user
      expect{
        post :create, params: {product: {title: "abcde", description:"a product", price: 789}}
      }.to change(Product,:count).by(1)
      expect(assigns(:user)).not_to be_nil
      expect(assigns(:product)).not_to be_nil
      expect(response).to redirect_to(product_path(assigns(:product)))
    end
    it "render the new action for invalid product" do
      sign_in_user
      allow_any_instance_of(Product).to receive(:save).and_return(false)
      post :create, params: {product: {title: "abcde", description:"a product", price: 789}}
      expect(response).to render_template(:new)
    end
  end
  context "#edit" do
    it "finds the product and renders edit page" do
      sign_in_user
      get :edit, params: {id: product.id}
      expect(assigns(:product)).to eq(product)
      expect(response).to render_template(:edit)
    end
  end
  context "#update" do
    it "updates the product and redirect successfully" do
      sign_in_user
      patch :update, params: {id: product.id, product: {title: "abcde", description:"a product", price: 789, availability: false}}
      expect(assigns(:product)).to eq(product)
      product.reload
      expect(product.title).to eq("abcde")
      expect(product.description).to eq("a product")
      expect(product.price).to eq 789
      expect(response).to redirect_to(assigns(:product))
    end
    it "renders the edit page for invalid update" do
      sign_in_user
      allow_any_instance_of(Product).to receive(:update).and_return(false)
      patch :update, params: {id: product.id, product: {title: "abcde", description:"a product", price: 789, availability: false}}
      product.reload
      expect(product.title).not_to eq("abcde")
      expect(product.description).not_to eq("a product")
      expect(product.price).not_to eq 789
      expect(response).to render_template(:edit)
    end
  end
  context "#show" do
    it "finds the product successfully and displays it" do
      get :show, params: {id: product.id}
      expect(assigns(:product)).to eq(product)
      expect(response).to render_template(:show)
    end
    it "renders 404 for invalid product id" do
      get :show, params: {id: 999}
      expect(response.status).to eq(404)
    end
  end
  context "#destroy" do
    it "destroys the product successfully" do
      product
      expect{
        delete :destroy, params: {id: product.id}
      }.to change(Product,:count).by(-1)
    end
  end
end
