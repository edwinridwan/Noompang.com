class NotificationsController < ApplicationController

  def index
    @user = current_user
    # update user's last read attribute
    User.update_all ['last_read = ?', Time.now], ['id = ?', current_user.id] # TODO: should check for successful update
    @notifications = Notification.find_all_by_target_id(@user)
  end

end
