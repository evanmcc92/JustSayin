class MicropostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :voteup, :votedown]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.up = 0
    @micropost.down = 0
    if @micropost.save
      redirect_to :back
    else
      @feed_items = []
      redirect_to :back
    end
  end

  def destroy
    @micropost.destroy
    redirect_to :back
  end

  def voteup
    @micropost = Micropost.find(params[:id])
    @micropost.increment!(:up)
    redirect_to :back
  end

  def votedown
    @micropost = Micropost.find(params[:id])
    @micropost.increment!(:down)
    if @micropost.save
      redirect_to :back
    end
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
