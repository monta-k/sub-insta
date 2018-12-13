class PagesController < ApplicationController
before_action :signed_in?, only: [:index]

  def index
    @posts = current_user.feed.includes(:photos, :user, :likes).order('created_at DESC').page(params[:page]).per(30)
  end

  def terms
    respond_to do |format|
      format.html { redirect_to pages_terms_path }
      format.js
    end
  end

  def search
    if params[:search_type] == "0"
      @search_result = User.where("name LIKE ?", "%#{params[:search_content]}%")
      @count = @search_result.count
      @users = @search_result.page(params[:page]).per(10)
    elsif params[:search_type] == "1"
      @search_result = Post.where("caption LIKE ?", "%#{params[:search_content]}%")
      @count = @search_result.count
      @posts = @search_result.page(params[:page]).per(30)
    else
      redirect_to root_path
    end
  end

  private
    def signed_in?
      unless user_signed_in?
        redirect_to new_user_session_path
      end
    end
end
