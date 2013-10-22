class BrowseController < ApplicationController
  before_filter :update_poststream, :only => [:home, :refreshposts]

  def home
  end

  def aboutus
  end

  def message
  end

  def profile
  end

  def votedup
  	@post = Post.find(params[:id])
    @post.ups=@post.ups+1
    @post.save
    render :text => "<div class='up'></div>"+@post.ups.to_s+" likes"
  end

  def voteddown
  	@post = Post.find(params[:id])
    @post.downs=@post.downs+1
    @post.save
    render :text => "<div class='down'></div>"+@post.downs.to_s+" dislikes"
  end

  def refreshposts
  	render 'post', :locals => { :post_streams => @post_streams }
  end

  protected
  def update_poststream
  	@post_streams = Post.order('created_at DESC').all
  end
end
