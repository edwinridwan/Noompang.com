class RideAcceptNotification < Notification

  def init
    self.verb = "has accepted your ride for"
  end

  def render_message
    if (!self.subject_id || !self.object_id)
      "error"
    else
      user = User.find(self.subject_id)
      ride = Ride.find(self.object_id)
      if ride
        user.first_name + " " + user.last_name + " " + self.verb + " " + ride.start_date.to_s
      else
        user.first_name + " " + user.last_name + " accepted your ride"
      end
    end
  end
end