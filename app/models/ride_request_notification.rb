# == Schema Information
#
# Table name: notifications
#
#  id         :integer         not null, primary key
#  subject_id :integer         not null
#  verb       :string(255)     not null
#  target_id  :integer
#  type       :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  object_id  :integer
#
# Indexes
#
#  index_notifications_on_target_id   (target_id)
#  index_notifications_on_subject_id  (subject_id)
#

class RideRequestNotification < Notification

  def init
    self.verb = "requested your ride for"
  end

  def render_message
    if (!self.subject_id || !self.object_id)
      "error"
    else
      user = User.find(self.subject_id)
      ride = Ride.find(:all, :conditions => { :id => self.object_id }, :limit => 1)
      if ride.any?
        user.first_name + " " + user.last_name + " " + self.verb + " " + ride.first.start_date.to_s
      else
        user.first_name + " " + user.last_name + " requested a ride that has been deleted now"
      end
    end
  end
end
