include RideRequestsHelper

class RideRequestsController < ApplicationController

  def new
    @request = RideRequest.new
    @user = current_user
  end

  # TODO really has to be improved!
  def create 
    @request = RideRequest.new
    @request.ride_id = params[:ride]
    @request.user_id = current_user.id
    ride = Ride.find(params[:ride])
    user = User.find(@request.user_id)
    if ride.price <= user.balance
      price_per_passenger = ride.price
      # debit amount from passenger's balance
      old_balance = user.balance
      new_balance = old_balance - price_per_passenger
      User.update_all ['balance = ?', new_balance], ['id = ?', @request.user_id]
      
      # create request
      @request.start_date = ride.start_date
      @request.start_time = ride.start_time
      @request.end_date = ride.end_date
      @request.end_time = ride.end_time
      @request.start_lat = ride.start_lat
      @request.start_long = ride.start_long
      @request.end_lat = ride.end_lat
      @request.end_long = ride.end_long
      @request.start_address = params[:start_address]
      @request.end_address = params[:end_address]
      @request.request_code = ('a'..'z').to_a.shuffle[0..7].join
      if !@request.save
        # Unsuccessful save
        flash[:error] = "Oops there was an error!"
        render 'rides/search'
      end
      # notify driver
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
    else
      flash[:error] = "Insufficient funds"
      @user = current_user
      @ride = Ride.find(params[:ride])
      redirect_to :back
    end
  end

  def destroy
    RideRequest.find(params[:id]).destroy
    flash[:success] = "We have deleted your request."
    redirect_to current_user
  end

  def accept
    request = RideRequest.find(params[:id])
    RideRequest.update_all ['status = ?', "accepted"], ['id = ?', request.id]
    # notify passenger
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
    # notify passenger
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

  def redeem
    request = RideRequest.find(params[:request_id])
    input_code = params[:request_code]
    if request.request_code == input_code
      # valid code
      ride = Ride.find(request.ride_id)
      price_per_passenger = ride.price
      # credit amount to driver's balance
      old_balance = User.find(ride.user_id).balance
      new_balance = old_balance + price_per_passenger
      User.update_all ['balance = ?', new_balance], ['id = ?', ride.user_id]
      if RideRequest.update_all ['status = ?', "redeemed"], ['id = ?', request.id] != 1
        flash[:error] = "There was an error redeeming your ride"
      else 
        flash[:success] = "Successfully redeemed ride"
      end
    else
      # invalid code
      flash[:error] = 'Invalid ride code'
    end
    redirect_to show_ride_requests_path(:id => request.ride_id)
  end

  def rate_user
    # rate user
    request = RideRequest.find(params[:request_id])
    score = params[:score].to_f
    if current_user_owns_request?(request)
      # user is passenger and wants to rate driver
      user_id = Ride.find(request.ride_id).user_id
      RideRequest.update_all ['driver_score = ?, driver_score_date = ?', score, Time.now], ['id = ?', request.id]
    else
      # user is driver and wants to rate owner of this request
      user_id = request.user_id
      RideRequest.update_all ['passenger_score = ?, passenger_score_date = ?', score, Time.now], ['id = ?', request.id]
    end
    # update user with user_id
    user = User.find(user_id)
    new_votes = user.total_votes + 1
    new_score = user.total_score + score
    User.update_all ['total_votes = ?, total_score = ?', new_votes, new_score], ['id = ?', user_id]
    flash[:success] = "Thanks for voting. Your vote will help improving the community"
    redirect_to show_ride_path(:id => request.ride_id)
  end
end




    

