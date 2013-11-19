class BrowseController < ApplicationController
  def home
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed
    end
  end

  def profile
  end

  def message
  end

  def aboutus
  end
  
end
