class AddFurtherAddressInformation < ActiveRecord::Migration
  def change
    add_column :rides, :start_country, :string
    add_column :rides, :end_country, :string
    add_column :rides, :start_post_code, :string
    add_column :rides, :end_post_code, :string
    add_column :ride_requests, :start_country, :string
    add_column :ride_requests, :end_country, :string
    add_column :ride_requests, :start_post_code, :string
    add_column :ride_requests, :end_post_code, :string
  end
end
