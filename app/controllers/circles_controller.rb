class CirclesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @circles = Circle.all.order(is_private: :asc)
  end

  def new
    @circle = Circle.new
  end

  def create
    @id = current_user.id
    @circle = Circle.new(circle_params)
    @circle.user_id = @id
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
    member = Membership.where(circle_id: @circle)
    approved_member = member.where(user_id: current_user.id)
    if @circle.is_private == false
      @comments = @circle.comments.order(created_at: :desc)
      @pictures = Picture.where(circle_id: @circle.id)
    else
      if signed_in?
        if (current_user.id == @circle.user_id)
          @comments = @circle.comments.order(created_at: :desc)
          @pictures = Picture.where(circle_id: @circle.id)
        else
          @comments = @circle.comments.order(created_at: :desc)
          @pictures = Picture.where(circle_id: @circle.id)
          flash[:alert] = "You must join to have full access!"
        end
      else
        redirect_to root_path
        flash[:alert] = "You do not have access to that circle!"
      end
    end
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

  def pending
    @circle = Circle.find(params[:id])
    member = Membership.where(circle_id: @circle)
    @memberships = member.all
    if current_user.id == @circle.user_id
    else
      redirect_to circle_path(@circle)
    end
  end

  def approval
    @membership = Membership.find(params[:id])
    @membership.update_attributes(approved: true)
    @circle = @membership.circle_id
    flash[:notice] = "Approved!"
    redirect_to pending_path(@circle)
  end

  private

  def circle_params
    params.require(:circle).permit(:title, :description, :is_private)
  end


end
