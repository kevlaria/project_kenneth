class AddConfirmationToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :confirmation, :boolean, null: false, default: false
  end
end
