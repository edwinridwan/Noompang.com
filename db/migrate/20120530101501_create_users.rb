class CreateUsers < ActiveRecord::Migration
  def change
    drop_table :users

    create_table :users do |t|
      t.string :email, :null => false, unique: true
      t.string :password_digest, :null => false, unique: true
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :location
      t.string :mobile_number
      t.string :remember_token
      t.boolean :admin, default: false

      t.timestamps
    end
    # add indices
    add_index   :users, :email
    add_index   :users, :remember_token
  end
end
