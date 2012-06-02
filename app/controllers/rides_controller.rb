class RidesController < ApplicationController

  def new
    @ride = Ride.new
    @user = current_user
  end

  def create
    @ride = Ride.new(params[:ride])
    if @ride.save
      # Handle a successful save
      flash[:success] = "Ride successfully created"
      redirect_to @ride
    else
      # Unsuccessful save
      render 'new'
    end
  end

  def show
    @ride = Ride.find(params[:id])
  end

end
