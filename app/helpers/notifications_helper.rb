module NotificationsHelper

  def has_notifications?
    Notification.find_all_by_target_id(current_user).any?
  end

end
