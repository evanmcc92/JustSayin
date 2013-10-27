class BrowseController < ApplicationController
  def home
    @user = User.find(params[:id])
  end

  def profile
  end

  def message
  end

  def aboutus
  end
  
end
