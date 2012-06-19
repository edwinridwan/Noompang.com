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
  def match_ride(ride)
    @out_rides = []
    Ride.all.each do |r|
      start_dist = get_surface_distance(r.start_lat, r.start_long, 
                                    ride.start_lat, ride.start_long)
      end_dist = get_surface_distance(r.end_lat, r.end_long,
                                    ride.end_lat, ride.end_long)
      if (start_dist < 1.0 && end_dist < 1.0 && get_available_seats_count(r) > 0)
        @out_rides << r
      end
    end
    return @out_rides
  end

  def get_request_count(ride)
    ride.ride_requests.count
  end

  def get_available_seats_count(ride)
    ride.no_seats - ride.ride_requests.count
  end

  def has_offered_rides?
    Ride.find_by_user_id(current_user.id).any?
  end

  def ride_in_past?(ride)
    logger.debug "####################### " + ride.end_time.to_time.to_s
    logger.debug "####################### " + Time.now.to_s
    ride.end_time.to_time < Time.now
  end
    
end
