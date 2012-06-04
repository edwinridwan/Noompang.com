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
      redirect_to current_user
    else
      # Unsuccessful save
      flash[:success] = "Ride successfully created"
      render 'new'
    end
  end

  def show
    @ride = Ride.find(params[:id])
  end

end
