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

  # returns a list of ride between FIRST_RESULT_AT and LAST_RESULT_AT
  # depending on either RIDE.END_TIME or RIDE.START_TIME as specified
  # by SEARCH_BY
  def match_rides(ride, first_result_at, last_result_at, search_by)
    # this is a little hack, will definitely require some tweaking
    if search_by == 'arrival'
      # user requested rides based on end/arrival time of ride
      results = Ride.find(:all, :conditions => {:end_time => first_result_at..last_result_at})
    else
      # user requested rides based on start time of ride or DEFAULT
      results = Ride.find(:all, :conditions => {:start_time => first_result_at..last_result_at})
    end
    logger.debug "################### " + results.count.to_s
    results.delete_if { |r| get_surface_distance(r.start_lat, r.start_long, 
                                  ride.start_lat, ride.start_long) > 1.0 || 
                            get_surface_distance(r.end_lat, r.end_long,
                                  ride.end_lat, ride.end_long) > 1.0 ||
                            get_available_seats_count(r) == 0 ||
                            ride_in_past?(r) }
    logger.debug "################### " + results.count.to_s
    return results
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

  def ride_in_past?(ride)
    ride.end_time < Time.now
  end

  def get_price(ride)
    "S$" + ride.price.to_s
  end

  def current_user_is_driver?(ride)
    current_user.id == ride.user_id
  end

  def current_user_has_requested_ride?(ride)
    ride.ride_requests.where('user_id = ?', current_user.id).any?
  end

  # TODO  this has to be improved
  def get_regional_ride_count
    country = get_user_country(current_user)
    count = Ride.where('start_country = ? OR end_country = ?', country, country).count
    if count > 0
      count.to_s + " rides available in your region"
    else
      "Be the first one to offer a ride in your region"
    end
  end

  def rides_for_today
    first_result_at = Time.now
    last_result_at = Time.now.end_of_day
    Ride.find(:all, :conditions => {:start_time => first_result_at..last_result_at,
                                     :user_id => current_user.id})
  end

  def rides_for_tomorrow
    first_result_at = Time.now.tomorrow.beginning_of_day
    last_result_at = Time.now.tomorrow.end_of_day
    Ride.find(:all, :conditions => {:start_time => first_result_at..last_result_at,
                                     :user_id => current_user.id})
  end

  def rides_after_tomorrow
    first_result_at = Time.now.tomorrow.tomorrow.beginning_of_day
    Ride.where('start_time >= ? AND user_id = ?', first_result_at, current_user.id)
  end


  private
 
    def time_matches?(time_a, time_b, tolerance_in_minutes)
      abs_dif = (time_a - time_b).abs
      return abs_dif <= tolerance_in_minutes*60
    end
    
end
