class CommentsController < ApplicationController

  before_action :authenticate_user! 

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save!
      redirect_to product_path(@product), notice: "Comment has been created successfully"
    else
      render product_path(@product)
    end
  end

  def edit
    @product = Product.find(params[:product_id])
    @comment = @product.comments.find(params[:id])
  end

  def update
    @product = Product.find(params[:product_id])
    @comment = @product.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to product_path(@product), notice: "Comment has been updated successfully"
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to product_path(@product), notice: "Comment has been deleted successfully" 
  end

  private
    def comment_params
      params.require(:comment).permit(:comment,:product_id)
    end

end
