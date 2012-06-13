class ChangeRideRequestColumnNames < ActiveRecord::Migration
  def change
    rename_column :ride_requests, :pickup_date, :start_date
    rename_column :ride_requests, :pickup_time, :start_time
    rename_column :ride_requests, :dropoff_date, :end_date
    rename_column :ride_requests, :dropoff_time, :end_time
    rename_column :ride_requests, :pickup_address, :start_address
    rename_column :ride_requests, :dropoff_address, :end_address
    rename_column :ride_requests, :pickup_lat, :start_lat
    rename_column :ride_requests, :dropoff_lat, :end_lat
    rename_column :ride_requests, :pickup_long, :start_long
    rename_column :ride_requests, :dropoff_long, :end_long
  end
end
