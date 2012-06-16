class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :subject_id, :null => false
      t.string :verb, :null => false
      t.integer :target_id
      t.string :type, :null => false

      t.timestamps
    end
    add_index :notifications, :subject_id
    add_index :notifications, :target_id
  end
end
