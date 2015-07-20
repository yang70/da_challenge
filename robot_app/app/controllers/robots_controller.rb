class RobotsController < ApplicationController
  def index
    @robots = Robot.all
  end

  def show
    @robot = Robot.find(params[:id])
  end

  def new
    @robot = Robot.new
  end

  def edit
    @robot = Robot.find(params[:id])
  end

  def create
    @robot = Robot.new(robot_params)

    if @robot.save
      redirect_to @robot
    else
      render 'new'
    end
  end

  def update
    @robot = Robot.find(params[:id])

    if @robot.update(robot_params)
      redirect_to @robot
    else
      render 'edit'
    end
  end

  def destroy
    @robot = Robot.find(params[:id])
    @robot.destroy

    redirect_to robots_path
  end

  private
    def robot_params
      params.require(:robot).permit(:name, :special_attribute, :speed, :size)
    end
end
