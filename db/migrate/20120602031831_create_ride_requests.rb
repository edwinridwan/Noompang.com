class CreateRideRequests < ActiveRecord::Migration
  def change
    drop_table :ride_requests

    create_table :ride_requests do |t|
      t.references  :ride, :null => false
      t.references  :user, :null => false
      t.date :pickup_date
      t.time :pickup_time
      t.date :dropoff_date
      t.time :dropoff_time
      t.string :pickup_address
      t.string :dropoff_address
      t.float :pickup_lat
      t.float :pickup_long
      t.float :dropoff_lat
      t.float :dropoff_long
      t.string :request_code, :unique => true
      t.timestamps
    end
    add_index :ride_requests, :request_code
  end
end
