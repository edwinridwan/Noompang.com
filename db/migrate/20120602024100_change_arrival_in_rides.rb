class ChangeArrivalInRides < ActiveRecord::Migration
  def change
    remove_column :rides, :arrival
  end
end
