class UsersController < ApplicationController
  before_action :signed_in?

  def show
    @user = User.find(params[:id])
  end

  private
    def signed_in?
      unless user_signed_in?
        redirect_to new_user_session_path
      end
    end
end
