class AddHashToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :hash, :string
  end
end
