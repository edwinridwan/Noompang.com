class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  # TIME ZONE SUPPORT FOR EACH USER
  before_filter :set_time_zone

  def set_time_zone
    Time.zone = current_user.timezone if current_user
  end

end
