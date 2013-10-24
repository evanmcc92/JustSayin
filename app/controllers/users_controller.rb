class UsersController < ApplicationController
  def new
      @user = User.new
  end

  def create
      @user = User.new(params[:user])
      if @user.save
          session[:user_id] = @user.id
          redirect_to root_url
      else
          render :action => "new"
      end
  end

  def edit
    @user = :current_user
  end

  def update
    @user = :current_user
    respond_to do |format|
      if @user.update(params[:current_user])
        format.html { redirect_to root_url, flash[:notice] = SUCCESSFUL_REGISTRATION_UPDATE_MSG }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
     end
  end

  def destroy
  end
end
