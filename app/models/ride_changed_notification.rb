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

class RideChangedNotification < Notification

  def init
    # this could be a lot more fine-grained "changed the time/date...of your ride"
    # same really applies to all other notification classes
    self.verb = "has changed information of your requested ride for"
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
        user.first_name + " " + user.last_name + " changed your ride"
      end
    end
  end
end
