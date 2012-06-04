require 'date'

class RidesController < ApplicationController

  def new
    @ride = Ride.new
    @user = current_user
  end

  def create
    @ride = Ride.new(params[:ride])
    logger.info "*****DEBUG: " + params[:ride][:start_date]
    logger.info "*****DEBUG: " + @ride.start_date.to_s
    logger.info "*****DEBUG: " + params[:ride][:end_time]
    logger.info "*****DEBUG: Start time:" + @ride.start_time.to_s
    logger.info "*****DEBUG: End time:" + @ride.end_time.to_s


    
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
