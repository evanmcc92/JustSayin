class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = Micropost.find(params[:micropost_id])
	  @comment = @micropost.comments.build(comment_params)
    @comment.micropost_id = @micropost.id
    @comment.user_id = current_user.id
    @user = User.find_by(params[:id])

    if @comment.save
      redirect_to :back
    else
      @feed_items_comments = []
      redirect_to :back
    end
  end

  def destroy
    @comment.destroy
    redirect_to :back
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :user_id, :micropost_id)
    end

    def correct_user
      @comment = current_user.comments.find_by_id(params[:id])
      redirect_to root_url if @comment.nil?
    end
end
