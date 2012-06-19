class AddColumnsForLogin < ActiveRecord::Migration
  def up
    add_column :users, :sex, :string # should only be 1 char long
    add_column :users, :locale, :string
    add_column :users, :timezone, :string
    add_column :users, :provider, :string
    add_column :users, :uid, :string, :unique => true
  end

  def down
    remove_column :users, :sex
    remove_column :users, :locale
    remove_column :users, :timezone
    remove_column :users, :provider
    remove_column :users, :uid
  end
end
