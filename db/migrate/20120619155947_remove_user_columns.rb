class RemoveUserColumns < ActiveRecord::Migration
  def up
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at
    remove_column :users, :remember_created_at
  end

  def down
      ## Recoverable
      add_column :users, :reset_password_token, :string
      add_column :users, :reset_password_sent_at, :datetime

      ## Rememberable
      add_column :users, :remember_created_at, :datetime
  end
end
