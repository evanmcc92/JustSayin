class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user && User.authenticate(params[:email], params[:password])
      sign_in user
      redirect_back_or user
    else
      flash[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    sign_out
    redirect_to root_url
  end
end
