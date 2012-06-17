class AddObjectIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :object_id, :integer
  end
end
