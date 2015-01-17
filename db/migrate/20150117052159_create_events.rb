class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :type
      t.datetime :time
      t.integer :event_id

      t.timestamps
    end
  end
end
