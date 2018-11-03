class PagesController < ApplicationController
before_action :signed_in?, only: [:index]

  def index
  end

  def terms
    respond_to do |format|
      format.html { redirect_to pages_terms_path }
      format.js
    end
  end

  private
    def signed_in?
      unless user_signed_in?
        redirect_to new_user_session_path
      end
    end
end
