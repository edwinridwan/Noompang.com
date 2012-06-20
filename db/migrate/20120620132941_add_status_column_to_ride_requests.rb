class AddStatusColumnToRideRequests < ActiveRecord::Migration
  def change
    add_column :ride_requests, :status, :string, :null => false, :default => "pending"
  end
end
