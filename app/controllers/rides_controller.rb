include RidesHelper

class RidesController < ApplicationController

  def new
    @ride = Ride.new
  end

  def show
    @ride = Ride.find(params[:id])
  end

  def edit  
    @ride = Ride.find(params[:id])
    @user = current_user
  end

  def update
    @ride = Ride.find(params[:id])
    @user = current_user
    if @ride.update_attributes(params[:ride])
      notify_all_passengers(params[:id], "changed")
      flash[:success] = "Ride updated"
      redirect_to current_user
    else
      render 'edit'
    end

  end

  def create
    @ride = Ride.new(params[:ride])
    @ride.start_time = Time.zone.parse(params[:ride][:start_date] + ' ' + params[:ride][:start_time]).utc
    @ride.end_time = @ride.start_time + params[:duration].to_f.seconds
    if @ride.save
      # Handle a successful save
      flash[:success] = "Ride successfully created"
      redirect_to current_user
    else
      # Unsuccessful save
      flash[:success] = "Ride successfully created"
      render 'new'
    end
  end

  def search
    @ride = Ride.new
    @user = current_user
  end

  def show_search_results
    @ride = Ride.new(params[:ride])
    @ride.start_time = Time.zone.parse(params[:ride][:start_date] + ' ' + params[:ride][:start_time]).utc
    @outrides = []
    if (@ride.start_time >= Time.now)
      @user = current_user
      ride_start_lat = @ride.start_lat
      ride_start_long = @ride.start_long
      if params[:tolerance]
        @outrides = match_ride(@ride, params[:tolerance].to_i, params[:search_by])
      else
        @outrides = match_ride(@ride, 10, params[:search_by])
      end
    else
      @ride.errors.add(:start_date)
      @ride.errors.add(:start_time)
    end
    render 'search'
  end

  def destroy
    notify_all_passengers(params[:id], "deleted")
    Ride.find(params[:id]).destroy
    flash[:success] = "We have deleted your ride."
    redirect_to current_user
  end

  def show_requests
    @ride = Ride.find(params[:id])
    @user = current_user
  end

end
