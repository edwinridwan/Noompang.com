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
    flash[:error] = "We will implement this feature soon."
    redirect_to current_user
  end

  def create
    @ride = Ride.new(params[:ride])
    #logger.info "*****DEBUG: " + params[:ride][:start_date]
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
    all_rides = Ride.all
    @out_rides = []
    all_rides.each do |r|
      dist = get_surface_distance(r.start_lat, r.start_long, 
                                    ride_start_lat, ride_start_long)
      if (dist < 1.0)
        @out_rides << r
      end
    end
    render 'search'
  end

  def destroy
    Ride.find(params[:id]).destroy
    flash[:success] = "We have deleted your ride."
    redirect_to current_user
  end

end
