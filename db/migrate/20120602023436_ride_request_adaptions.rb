class RideRequestAdaptions < ActiveRecord::Migration
  def change
    rename_column :rides, :pickup_date, :start_date
    rename_column :rides, :pickup_time, :start_time
    rename_column :rides, :dropoff_date, :end_date
    rename_column :rides, :dropoff_time, :end_time
    rename_column :rides, :origin_address, :start_address
    rename_column :rides, :dst_address, :end_address
    rename_column :rides, :origin_lat, :start_lat
    rename_column :rides, :dst_lat, :end_lat
    rename_column :rides, :origin_long, :start_long
    rename_column :rides, :dst_long, :end_long
    rename_column :rides, :approx_arrival, :arrival 
  end
end
