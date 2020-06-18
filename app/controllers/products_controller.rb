class ProductsController < ApplicationController

	before_action :set_cache_headers, only: [:new, :create, :edit, :update] 
	
	def index
		@products = Product.all
	end

	def new
		@product = Product.new
	end

	def create
		@user = User.find(current_user.id)
		@product = @user.products.create!(product_params) 
		@product.update(serial_number: generate_serial_number(@product.id))
		redirect_to product_path(@product), notice: "Product has been added successfully!"		
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
			render :file => 'public/404.html' 
		end
	end

	def destroy
		@product = Product.find(params[:id])
		@product.destroy
		redirect_to root_path, notice: "Product has been deleted successfully"
	end

	def current_user_products
		authenticate_user
		@products = Product.where(user_id: current_user.id).all
		render 'index'
	end

	private
		def product_params
			params.require(:product).permit(:title, :price, :availability,:description,product_images: [])
		end

		def generate_serial_number id
			"PLN-%.6d" % id
		end

		def set_cache_headers
			response.headers["Cache-Control"] = "no-cache, no-store"
    	response.headers["Pragma"] = "no-cache"
			response.headers["Expires"] = "Mon, 01 Jan 1990 00:00:00 GMT"
			authenticate_user
		end

		def authenticate_user
			if current_user.nil?
			  redirect_to new_user_session_path and return
			end
		end

end
