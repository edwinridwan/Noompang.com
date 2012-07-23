module NotificationsHelper

  # Returns true if current_user has any notifications
  def has_notifications?
    Notification.find_all_by_target_id(current_user).any?
  end

  # Returns true if current_user has any new notifications, i.e. any
  # notifications that have been created since the user last read his
  # notifications
  def has_new_notifications?
    Notification.where("target_id = ? AND created_at >= ?", current_user.id, current_user.last_read).any?
  end

  # Returns new notifications, i.e. all notifications that have been created
  # since the user last read his notifications
  def new_notifications
    Notification.where("target_id = ? AND created_at >= ?", current_user.id, current_user.last_read)
  end

  # Returns old notifications, i.e. all notifications that had been created
  # before the user last read his notifications
  def old_notifications
    Notification.where("target_id = ? AND created_at < ?", current_user.id, current_user.last_read)
  end

  # Returns a count of new notifications, i.e. all notifications that have been
  # created since the user last read his notifications
  def new_notifications_count
    Notification.where("target_id = ? AND created_at >= ?", current_user.id, current_user.last_read).count
  end

end
