class CirclesController < ApplicationController
  before_action :authenticate_user!

  def index
    @circles = Circle.all
  end

  def new
    @circle = Circle.new
  end

  def create
    @circle = Circle.new(circle_params)
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
    @circle = Circle.find(params[:id])
  end

  def update
    @circle = Circle.find(params[:id])
    if @circle.update(circle_params)
      flash[:notice] = "Circle was successfully updated!"
      redirect_to @circle
    else
      render 'edit'
    end
  end

  def destroy
  end

  private

  def circle_params
    params.require(:circle).permit(:title, :description)
  end


end
