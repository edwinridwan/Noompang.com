class ChangeTimeColumns < ActiveRecord::Migration
  def up
    # rides
    change_column :rides, :start_time, :datetime
    change_column :rides, :end_time, :datetime

    add_column  :rides, :start_date, :date
    add_column  :rides, :end_date, :date
    # ride_requests
    change_column :ride_requests, :start_time, :datetime
    change_column :ride_requests, :end_time, :datetime
    add_column  :ride_requests, :start_date, :date
    add_column  :ride_requests, :end_date, :date
  end

  def down
    # rides
    change_column :rides, :start_time, :time
    change_column :rides, :end_time, :time
    remove_column  :rides, :start_date
    remove_column  :rides, :end_date
    # ride_requests
    change_column :ride_requests, :start_time, :time
    change_column :ride_requests, :end_time, :time
    remove_column  :ride_requests, :start_date
    remove_column  :ride_requests, :end_date
  end
end
