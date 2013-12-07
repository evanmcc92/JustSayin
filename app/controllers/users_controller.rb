class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user = User.new
  end

  def index
    if params[:search]
      @user = User.search(params[:search]).order("created_at DESC")
    else
      @user = User.all.order('created_at DESC')
    end
  end

  def create
      @user = User.new(user_params)
      if @user.save
        sign_in @user
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
    if @user.update_attributes(update_user_params)
      redirect_to edit_user_path(@user), :flash => {:success => "You've Successful Updated Your Account!"}
    else
      render "edit"
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    session[:user_id] = nil
    redirect_to root_url
  end

  def show
    @user = User.find(params[:id])

    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    else
      @users = User.all.order('created_at DESC')
    end

    @microposts = @user.microposts if signed_in?
    @micropost  = current_user.microposts.build
    @comments = @micropost.comments if signed_in?
    @comment = Comment.new
  end

  private

    def user_params
      params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
    end

    def update_user_params
      params.require(:user).permit(:user_name, :first_name, :last_name, :user_bio, :email, :password, :password_confirmation)
    end

    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
