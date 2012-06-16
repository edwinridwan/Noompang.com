class NotificationsController < ApplicationController

  def index
    @user = current_user
    @notifications = Notification.find_all_by_target_id(@user)
  end

end
