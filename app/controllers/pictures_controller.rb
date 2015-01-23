class PicturesController < ApplicationController
  before_action :authenticate_user!

  def create
    @circle = Circle.find(params[:circle_id])
    @picture = Picture.new(picture_params)
    @picture.circle_id = @circle.id
    @picture.user_id = current_user.id
    if @picture.save
      redirect_to circle_path(@circle)
      flash[:success] = "You've successfully uploaded a picture!"
    else
      redirect_to circle_path(@circle)
      flash[:alert] = @picture.errors.full_messages.join(".  ")
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    @circle = @picture.circle
    if current_user.id == @picture.user_id
      @picture.destroy
      flash[:success] = "You've successfully deleted your picture!"
    else
      flash[:alert] = "You are not authorized to do this."
    end
    redirect_to circle_path(@circle)
  end

  private

  def picture_params
    params.require(:picture).permit(:image)
  end

end
