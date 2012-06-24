class AddRatingColumnsToRequests < ActiveRecord::Migration
  def change
    add_column :ride_requests, :driver_score, :float
    add_column :ride_requests, :driver_score_date, :datetime
    add_column :ride_requests, :passenger_score, :float
    add_column :ride_requests, :passenger_score_date, :datetime
  end
end
