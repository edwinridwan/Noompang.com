require 'date'

class RidesController < ApplicationController

  def new
    @ride = Ride.new
    @user = current_user
  end

  def create
    @ride = Ride.new(params[:ride])
    #logger.info "*****DEBUG: " + params[:ride][:start_date]
    if @ride.save
      # Handle a successful save
      flash[:success] = "Ride successfully created"
      redirect_to @ride
    else
      # Unsuccessful save
      render 'users/show'
    end
  end

  def show
    @ride = Ride.find(params[:id])
  end

end
