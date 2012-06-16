class RideRequestNotification < Notification

  def init
    self.verb = "has requested a ride"
  end

  def render_message
    user = User.find(self.subject_id)
    user.first_name + " " + user.last_name + " " + self.verb
  end
end
