class CirclesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @circles = Circle.all
  end

  def new
    @circle = current_user.circles.build
  end

  def create
    @circle = current_user.circles.build(circle_params)
    if @circle.save
      flash[:notice] = "You've successfully created a circle!"
      redirect_to @circle
    else
      flash[:alert] = @circle.errors.full_messages
      render "new"
    end
  end

  def show
    @circle = Circle.find(params[:id])
  end

  def edit
    @circle = current_user.circles.find(params[:id])
  end

  def update
    @circle = current_user.circles.find(params[:id])
    if current_user.id == @circle.user_id
      if @circle.update(circle_params)
        flash[:notice] = "You've successfully updated a circle!"
        redirect_to @circle
      else
        render 'edit'
      end
    else
      redirect_to root_path
      flash[:alert] = "You are not the owner of that circle!"
    end
  end

  def destroy
    @circle = Circle.find(params[:id])
    if current_user.id == @circle.user_id
      @circle.destroy
        flash[:notice] = "You've successfully deleted a circle!"
      redirect_to root_path
    else
      flash[:alert] = "You are not the owner of that circle!"
      redirect_to circle_path(@circle)
    end
  end

  private

  def circle_params
    params.require(:circle).permit(:title, :description)
  end


end
