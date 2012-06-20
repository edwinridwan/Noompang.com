include RidesHelper

class RidesController < ApplicationController

  def new
    @ride = Ride.new
    @user = current_user
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
    if @ride.update_attributes(params[:ride])
      flash[:success] = "Ride updated"
      redirect_to current_user
    else
      render 'edit'
    end

  end

  def create
    @ride = Ride.new(params[:ride])
    @ride.start_time = Time.zone.parse(params[:ride][:start_date] + ' ' + params[:ride][:start_time]).utc
    @ride.end_time = Time.zone.parse(params[:ride][:end_date] + ' ' + params[:ride][:end_time]).utc
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
    @user = current_user
    @ride = Ride.new(params[:ride])
    ride_start_lat = @ride.start_lat
    ride_start_long = @ride.start_long
    @outrides = match_ride(@ride)
    render 'search'
  end

  def destroy
    Ride.find(params[:id]).destroy
    flash[:success] = "We have deleted your ride."
    redirect_to current_user
  end

  def show_requests
    @ride = Ride.find(params[:id])
    @user = current_user
  end

end
