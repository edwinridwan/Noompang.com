class RideRequestsControllerController < ApplicationController

  def new
    @request = RideRequest.new
    @user = current_user
  end

  def create
    @ride = RideRequest.new(params[:ride])
    #logger.info "*****DEBUG: " + params[:ride][:start_date]
    if @ride.save
      # Handle a successful save
      flash[:success] = "Ride successfully requested"
      redirect 'search'
    else
      # Unsuccessful save
      flash[:success] = "Oops there was an error!"
      render 'new'
    end
  end

end
