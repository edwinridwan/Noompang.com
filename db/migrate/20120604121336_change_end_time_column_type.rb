class ChangeEndTimeColumnType < ActiveRecord::Migration
  def up
    change_column :rides, :end_time, :time
  end

  def down
    change_column :rides, :end_time, :date
  end
end
