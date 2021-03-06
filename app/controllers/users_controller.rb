class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:photos, :user, :likes).order('created_at DESC').page(params[:page]).per(30)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "プロフィールを編集しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @page_title = "following"
    @title = "フォローしている"
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(10)
    render "show_follow"
  end

  def followers
    @page_title = "followers"
    @title = "フォローされている"
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(10)
    render "show_follow"
  end


  private

    def user_params
      params.require(:user).permit(:full_name, :name, :website, :bio, :email, :phonenumber, :sex)
    end

end
