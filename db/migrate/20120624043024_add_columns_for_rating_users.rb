class AddColumnsForRatingUsers < ActiveRecord::Migration
  def change
    add_column :users, :total_votes, :integer, :default => 0
    add_column :users, :total_score, :integer, :default => 0
  end
end
