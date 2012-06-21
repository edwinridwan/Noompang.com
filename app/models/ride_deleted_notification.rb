class RideDeletedNotification < Notification

  def init
    self.verb = "has deleted your requested ride for"
  end

  def render_message
    if (!self.subject_id || !self.object_id)
      "error"
    else
      user = User.find(self.subject_id)
      #ride = Ride.find(:all, self.object_id)
      ride = Ride.find(:all, :conditions => { :id => self.object_id }, :limit => 1)
      if ride.any?
        user.first_name + " " + user.last_name + " " + self.verb + " " + ride.first.start_date.to_s
      else
        user.first_name + " " + user.last_name + " deleted your requested ride"
      end
    end
  end
end
