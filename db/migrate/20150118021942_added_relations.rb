class AddedRelations < ActiveRecord::Migration
  def change
  	change_table :orders do |t|
      t.belongs_to :user, index: true
    end
  	change_table :nests do |t|
      t.belongs_to :user, index: true
    end
  	change_table :weathers do |t|
      t.belongs_to :user, index: true
    end
  end
end
