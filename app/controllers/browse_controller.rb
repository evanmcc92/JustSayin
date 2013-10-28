class BrowseController < ApplicationController
  def home
  	@user = current_user
  end

  def profile
  end

  def message
  end

  def aboutus
  end
  
end
