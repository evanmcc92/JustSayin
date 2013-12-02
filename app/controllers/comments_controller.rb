class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = Comment.new(params[:comment])
    @comment.micropost = @micropost
    @comment.user = current_user
    if @comment.save
       flash[:success] = "Comment created!"
       redirect_to current_user
    else
      render '/'
    end
  end

  def destroy
    @micropost= Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.find(params[:id])
    @comment.destroy
    redirect_to root_path
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def correct_user
      @comment = micropost.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end
end
