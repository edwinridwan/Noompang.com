module RideRequestsHelper

  # returns true if the current user is the owner of the request passed
  def user_owns_request?(request)
    return request.user_id == current_user.id
  end

  def user_owns_ride?(request)
    ride = Ride.find(request.ride_id)
    return ride.user_id == current_user.id
  end

  def request_pending?(request)
    request = RideRequest.find(request.id)
    return request && request.status == 'pending'
  end

  def request_accepted?(request)
    request = RideRequest.find(request.id)
    return request && request.status == 'accepted'
  end

  def ride_in_past?(request)
    request.end_time.to_time < Time.now
  end

end
