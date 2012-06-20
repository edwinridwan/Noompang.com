class RideRequestsController < ApplicationController

  def new
    @request = RideRequest.new
    @user = current_user
  end

  def create
    @request = RideRequest.new
    @request.ride_id = params[:ride]
    @request.user_id = current_user.id
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
    if !@request.save
      # Unsuccessful save
      flash[:error] = "Oops there was an error!"
      render 'rides/search'
    end
    # notify driver ###
    ride = Ride.find(@request.ride_id)
    notification = RideRequestNotification.new(:subject_id => @request.user_id, 
                                               :target_id => ride.user_id, 
                                               :object_id => @request.ride_id)
    if !notification.save
      # Unsuccessful save
      flash[:error] = "We could not notify the user!"
      render 'rides/search'
    end
    # Handle a successful save
    flash[:success] = "Ride successfully requested"
    redirect_to current_user
  end

  def destroy
    RideRequest.find(params[:id]).destroy
    flash[:success] = "We have deleted your request."
    redirect_to current_user
  end

  def accept
    request = RideRequest.find(params[:id])
    RideRequest.update_all ['status = ?', "accepted"], ['id = ?', request.id]
    # notify passenger ###
    ride = Ride.find(request.ride_id)
    driver_id = Ride.find(request.ride_id).user_id
    notification = RideAcceptNotification.new(:subject_id => driver_id, 
                                               :target_id => request.user_id, 
                                               :object_id => ride.id)
    if !notification.save
      # Unsuccessful save
      flash[:error] = "We could not notify the user!"
    end
    redirect_to show_ride_requests_path(:id => request.ride_id)
  end

  def decline
    request = RideRequest.find(params[:id])
    RideRequest.update_all ['status = ?', "declined"], ['id = ?', request.id]
    # notify passenger ###
    ride = Ride.find(request.ride_id)
    driver_id = Ride.find(request.ride_id).user_id
    notification = RideDeclineNotification.new(:subject_id => driver_id, 
                                               :target_id => request.user_id, 
                                               :object_id => ride.id)
    if !notification.save
      # Unsuccessful save
      flash[:error] = "We could not notify the user!"
    end
    redirect_to show_ride_requests_path(:id => request.ride_id)
  end
end




    

