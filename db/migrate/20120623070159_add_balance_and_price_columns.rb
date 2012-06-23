class AddBalanceAndPriceColumns < ActiveRecord::Migration
  def change
    add_column :users, :balance, :decimal, :precision => 4, :scale => 2, :default => 0.00
    add_column :rides, :price, :decimal, :precision => 4, :scale => 2
  end
end
