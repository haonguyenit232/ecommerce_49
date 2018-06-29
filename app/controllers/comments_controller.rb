class CommentsController < ApplicationController
  before_action :load_product
  before_action :load_comment, only: %i(edit update destroy)
  before_action :load_comment_reply, only: :new

  def new; end

  def create
    @comment = current_user.comments.build comment_params
    @comment.product_id = params[:product_id]
    respond_to do |format|
      if @comment.save
        format.html{redirect_to @product}
        format.js
      else
        flash[:warning] = t "create_fail"
        format.html{render @product}
      end
    end
  end

  def edit; end

  def update
    @current_comment = params[:id]
    respond_to do |format|
      if @comment.update comment_params
        format.html{redirect_to @product}
        format.js
      else
        flash[:danger] = t "update_fail"
        format.html{render :edit}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @comment.destroy
        format.html{redirect_to @product}
        format.js
      else
        flash[:danger] = t "delete_fail"
        format.html{redirect_to @product}
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit :content, :reply_to
  end

  def load_product
    @product = Product.find_by id: params[:product_id]
    valid_object unless @product
  end

  def load_comment
    @comment = @product.comments.find_by id: params[:id]
    valid_object unless @comment
  end
<<<<<<< 888dcd5dbcd4d36e2a16eb4d978013e4d4d7f560

  def load_comment_reply
    @reply_to =  params[:comment_id]
  end
=======
>>>>>>> Comment
end
