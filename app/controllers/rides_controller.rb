include RidesHelper

class RidesController < ApplicationController
  respond_to :html, :xml, :json # ajax communication for this controller

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
    @ride.start_time = Time.zone.parse(params[:ride][:start_date] +
                         ' ' + params[:ride][:start_time])
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

  # TODO to be improved
  def show_search_results
    @ride = Ride.new(params[:ride])
    tolerance = 10 # default
    search_by = params[:search_by]
    start_address = @ride.start_address
    end_address = @ride.end_address
    # determine interval for search results
    case params[:time_mode]
    when "thirty_mins"
      first_result_at = Time.now
      last_result_at = Time.now + 30.minutes
    when "sixty_mins"
      first_result_at = Time.now.utc
      last_result_at = Time.now + 30.minutes
    when "today"
      first_result_at = Time.now
      last_result_at = Time.now.end_of_day
    when "tomorrow"
      first_result_at = Time.now.tomorrow.beginning_of_day
      last_result_at = Time.now.tomorrow.end_of_day
    when "custom"
      requested_time = Time.zone.parse(params[:ride][:start_date] +
                                  ' ' + params[:ride][:start_time])
      if requested_time <= Time.now
        # user searched for rides in past
        @ride.errors.add(:start_date)
        @ride.errors.add(:start_time)
        redirect_to searchride_path(:ride => @ride)
      end
      tolerance = params[:tolerance].to_i if params[:tolerance]
      first_result_at = requested_time - tolerance.minutes
      last_result_at = requested_time + tolerance.minutes
    else
      # TODO implement fallback behaviour
    end
    # retrieve rides between FIRST_RESULT_AT and LAST_RESULT_AT
    @outrides = match_rides(@ride, first_result_at, last_result_at, params[:search_by])
    respond_with do |format|
      format.html do
        if request.xhr? # has controller received an ajax request?
          render :partial => "rides/search_results", 
                  :locals => { :out_rides => @outrides }, :layout => false
        else
          redirect_to searchride_path(:ride => @ride)
        end
      end
    end
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

  private

    

end
