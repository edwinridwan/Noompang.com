module RidesHelper

  R = 6371 # earth's radius in km

  def get_surface_distance(x_lat, x_long, y_lat, y_long)
    # Source: http://www.movable-type.co.uk/scripts/latlong.html
    # Haversine formula
    #d_lat = (y_lat - x_lat) * Math::PI / 180
    #d_long = (y_long - x_long) * Math::PI / 180
    #x_lat = x_lat * Math::PI / 180
    #y_lat = y_lat * Math::PI / 180

    #a = Math.sin(d_lat/2) * Math.sin(d_lat/2) + 
    #    Math.sin(d_long/2) * Math.sin(d_long/2) *
    #    Math.cos(x_lat) * Math.cos(y_lat)
    #c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    #return R * c
    #x_lat = x_lat * Math::PI / 180;
    #y_lat = y_lat * Math::PI / 180;
    #x_long = x_long * Math::PI / 180;
    #y_long = y_long * Math::PI / 180;
    
    #dx = (y_long - y_long) * Math.cos((x_lat+y_lat)/2)
    #dy = (y_lat - x_lat)
    #d = Math.sqrt(dx * dx + dy * dy) * R
    #return d
    d = Geocoder::Calculations.distance_between([x_lat, x_long], [y_lat, y_long])
    d = Geocoder::Calculations.to_kilometers(d)
    return d
  end

  # Return matching rides
  # TODO THIS HAS TO BE SIGNIFICANTLY IMPROVED
  def match_ride(ride, tolerance_in_minutes)
    @out_rides = []
    Ride.all.each do |r|
      start_dist = get_surface_distance(r.start_lat, r.start_long, 
                                    ride.start_lat, ride.start_long)
      end_dist = get_surface_distance(r.end_lat, r.end_long,
                                    ride.end_lat, ride.end_long)
      if (start_dist < 1.0 && end_dist < 1.0 && get_available_seats_count(r) > 0 && !ride_in_past?(r) && time_matches?(r.start_time, ride.start_time, tolerance_in_minutes))
        @out_rides << r
      end
    end
    return @out_rides
  end

  def get_request_count(ride)
    ride.ride_requests.count
  end

  def get_accepted_request_count(ride)
    ride.ride_requests.count(:conditions => [ "status = ?" , "accepted" ])
  end

  def get_available_seats_count(ride)
    ride.no_seats - get_accepted_request_count(ride)
  end

  def has_requests?(ride)
    get_request_count(ride) > 0
  end

  # returns true if current user has offered any rides
  def has_offered_rides?
    Ride.find_by_user_id(current_user.id).any?
  end

  # returns true if passed ride is owned by current user
  def user_owns_ride?(ride)
    ride.user_id == current_user.id
  end

  def notify_all_passengers(ride_id, action)
    ride = Ride.find(ride_id)
    requests = ride.ride_requests
    if requests.any?
      driver_id = ride.user_id
      # for every request, notify owner of request, ie. passenger
      requests.each do |request|
        #if request.status == 'accepted'
          if action == "changed"
            notification = RideChangedNotification.new(:subject_id => driver_id, 
                                                       :target_id => request.user_id, 
                                                       :object_id => ride_id)
          elsif action == "deleted"
            notification = RideDeletedNotification.new(:subject_id => driver_id, 
                                           :target_id => request.user_id, 
                                           :object_id => ride_id)
          end
          if !notification.save
            # Unsuccessful save
            flash[:error] = "We could not notify the user!"
          end
        #end
      end
    end
  end

  def get_driver_name(ride)
    user = User.find(ride.user_id)
    user.first_name + " " + user.last_name
  end

  def ride_in_past?(ride)
    ride.end_time < Time.now
  end

  def get_price(ride)
    "S$" + ride.price.to_s
  end

  private
 
    def time_matches?(time_a, time_b, tolerance_in_minutes)
      abs_dif = (time_a - time_b).abs
      return abs_dif <= tolerance_in_minutes*60
    end
    
end
