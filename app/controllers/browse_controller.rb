class BrowseController < ApplicationController
  def home
    @user = User.find(params[:id])
    render 'home'
  end

  def profile
  end

  def message
  end

  def aboutus
  end
  
end
