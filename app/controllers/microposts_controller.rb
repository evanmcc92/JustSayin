class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    
    if @micropost.save
      redirect_to root_path
    else
      @feed_items = []
      render 'browse/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_path
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_path if @micropost.nil?
  end
end
