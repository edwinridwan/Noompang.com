class AddSeatCountToRides < ActiveRecord::Migration
  def change
    add_column :rides, :no_seats, :integer
  end
end
