class UsersController < ApplicationController
  before_action :signed_in?

  def show
    @user = User.find(params[:id])
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


  private
    def signed_in?
      unless user_signed_in?
        redirect_to new_user_session_path
      end
    end

    def user_params
      params.require(:user).permit(:full_name, :name, :website, :bio, :email, :phonenumber, :sex)
    end

end
