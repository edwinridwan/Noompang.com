class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.references  :user, :null => false   # driver
                                            # passenger(s)
      t.string      :origin_address, :null => false
      t.string      :dst_address, :null => false
      t.float       :origin_lat
      t.float       :origin_long
      t.float       :dst_lat
      t.float       :dst_long
      t.date        :pickup_date, :null => false
      t.time        :pickup_time, :null => false
      t.date        :dropoff_date, :null => false
      t.date        :dropoff_time, :null => false
      t.time        :approx_arrival
      t.integer     :distance_in_meters
      t.timestamps
    end
    add_index   :rides, :user_id
  end
end
