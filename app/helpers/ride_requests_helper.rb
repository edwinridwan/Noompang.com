module RideRequestsHelper

  # returns true if the current user is the owner of the request passed
  def user_owns_request?(request)
    return request.user_id == current_user.id
  end

  def request_user_owns_ride?(request)
    ride = Ride.find(request.ride_id)
    return ride.user_id == current_user.id
  end

  def request_pending?(request)
    return request && request.status == 'pending'
  end

  def request_accepted?(request)
    return request && request.status == 'accepted'
  end

  def request_in_past?(request)
    request.end_time < Time.now
  end

  def request_to_be_redeemed?(request)
    request_user_owns_ride?(request) && request_accepted?(request) && request_in_past?(request)
  end

  def user_to_be_rated?(request)
    ride = Ride.find(request.ride_id)
    driver_can_vote = current_user_is_driver?(ride) && request.passenger_score_date == nil # true if driver has not voted yet
    passenger_can_vote = current_user_is_passenger?(ride) && request.driver_score_date == nil # true if passenger has not voted yet
    request.status == 'redeemed' && (driver_can_vote || passenger_can_vote)
                        # && request_in_past?(request) taken out for testing
  end

  def current_user_owns_request?(request)
    request.user_id == current_user.id
  end

end
