class ProductsController < ApplicationController
	
	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :current_user_products]

	def index
		@products = Product.search(params[:search], order: :title)
	end
	
	def new
		@product = Product.new
	end

	def create
		@user = User.find(current_user.id)
		@product = @user.products.new(product_params)
		if (@product.save)
			redirect_to product_path(@product), notice: "Product has been added successfully!"
		else
			render 'new'
		end
	end

	def edit
		@product = Product.find(params[:id])
	end

	def update
		@product = Product.find(params[:id])
		if @product.update(product_params)
			redirect_to @product, notice: "Updated product successfully!"
		else
			render 'edit'
		end
	end

	def show
		if Product.exists?(params[:id])
			@product = Product.find(params[:id])
		else
			render :file => 'public/404.html', status: 404
		end
	end

	def destroy
		@product = Product.find(params[:id])
		@product.destroy
		redirect_to root_path, notice: "Product has been deleted successfully"
	end

	def current_user_products
		@products = Product.where(user_id: current_user.id).all
		render 'index'
	end

	private
		def product_params
			params.require(:product).permit(:title, :price, :availability, :description, product_images: [])
		end
end
