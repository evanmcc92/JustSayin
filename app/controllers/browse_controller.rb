class BrowseController < ApplicationController
  def home
  	@micropost = user.microposts.build
  end

  def profile
  end

  def message
  end

  def aboutus
  end
  
end
