class MembershipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @circle = Circle.find(params[:circle_id])
    @membership = Membership.new
    @membership.circle_id = @circle.id
    @membership.user_id = current_user.id
    if @membership.save
      redirect_to circle_path(@circle)
      flash[:success] = "You must now wait for approval!"
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :circle_id)
  end

end
