class CommentsController < ApplicationController
  before_action :authenticate_user!
  after_action :create_notifications, only: [:create]

  def index
    @comments = @post.comments.includes(:user)
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      @post = @comment.post
      respond_to :js
    else
      flash[:alert] = "コメントに失敗しました"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    if @comment.destroy
      respond_to :js
    else
      flash[:alert] = "コメントの削除に失敗しました"
    end
  end

  private

    def comment_params
      params.required(:comment).permit(:post_id, :user_id, :comment)
    end

    def create_notifications
      return if @post.user_id == current_user.id
      Notification.create(user_id: @post.user_id,
                        notified_by_id: current_user.id,
                        post_id: @post.id,
                        notified_type: "コメント")
    end
end
