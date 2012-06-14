class RideRequestsController < ApplicationController

  def new
    @request = RideRequest.new
    @user = current_user
  end

  def create
    @request = RideRequest.new[params]
    @request.ride_id = params[:ride]
    @request.user_id = current_user
    @request.start_date = params[:start_date]
    @request.start_time = params[:start_time]
    @request.end_date = params[:end_date]
    @request.end_time = params[:end_time]
    @request.start_address = params[:start_address]
    @request.end_address = params[:end_address]
    @request.start_lat = 0.0
    @request.start_long = 0.0
    @request.end_lat = 0.0
    @request.end_long = 0.0
    @request.request_code = ('a'..'z').to_a.shuffle[0..7].join
    if @request.save
      # Handle a successful save
      flash[:success] = "Ride successfully requested"
      redirect_to current_user
    else
      # Unsuccessful save
      flash[:success] = "Oops there was an error!"
      render 'rides/search'
    end
  end

  def destroy
    RideRequest.find(params[:id]).destroy
    flash[:success] = "We have deleted your request."
    redirect_to current_user
  end

end




    

