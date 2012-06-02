class RidesController < ApplicationController

  def new
    @ride = Ride.new
    @user = current_user
  end

  def create

  end

end
