class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
  	@comment = current_user.comments.create(comment_params)
  	if @comment.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_comment_items = []
      redirect_to 'browse/home'
    end
  end

  def destroy
    @comment.destroy
    redirect_to root_path
  end

  private

    def comment_params
      params.require(:comment).permit(:comment, :micropost_id, :user_id)
    end

    def correct_user
      @comment = micropost.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end
end
