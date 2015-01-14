class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @circle = Circle.find(params[:circle_id])
    @comment = Comment.new(comment_params)
    @comment.circle_id = @circle.id
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to circle_path(@circle)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
