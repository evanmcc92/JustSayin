class UsersController < ApplicationController
  def new
      @user = User.new
  end

  def create
      @user = User.new(params[:user])
      if @user.save
        UserMailer.welcome_email(@user).deliver
        session[:user_id] = @user.id
        redirect_to @user
      else
        render :action => "new"
      end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    # required for settings form to submit when password is left blank
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    if @user.update_attributes(params[:user])
      redirect_to edit_user_path(@user), :flash => {:success => "You've Successful Updated Your Account!"}
    else
      render "edit"
    end
  end

  def destroy
  end

  def show
    @user = User.find(params[:id])
  end
end
