class CreateNests < ActiveRecord::Migration
  def change
    create_table :nests do |t|
      t.string :product
      t.integer :temperature

      t.timestamps
    end
  end
end
