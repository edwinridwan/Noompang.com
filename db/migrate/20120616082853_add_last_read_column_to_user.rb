class AddLastReadColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_read, :timestamp
  end
end
