class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :manifest
      t.string :pickup_name
      t.string :pickup_address
      t.string :pickup_phone_number
      t.string :pickup_business_name
      t.text :pickup_notes
      t.string :dropoff_name
      t.string :dropoff_address
      t.string :dropoff_phone_number
      t.string :dropoff_business_name
      t.text :dropoff_notes
      t.string :quote_id

      t.timestamps
    end
  end
end
