class CreateRideRequests < ActiveRecord::Migration
  def change
    create_table :ride_requests do |t|

      t.timestamps
    end
  end
end
