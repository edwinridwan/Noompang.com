module NotificationsHelper

  def has_notifications?
    Notification.find_all_by_target_id(current_user).any?
  end

  def has_new_notifications?
    Notification.where("target_id = ? AND created_at >= ?", current_user.id, current_user.last_read).any?
  end

  def new_notifications
    Notification.where("target_id = ? AND created_at >= ?", current_user.id, current_user.last_read)
  end

  def old_notifications
    Notification.where("target_id = ? AND created_at < ?", current_user.id, current_user.last_read)
  end

  def new_notifications_count
    Notification.where("target_id = ? AND created_at >= ?", current_user.id, current_user.last_read).count
  end

end
