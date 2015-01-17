class RenameHashToSomething < ActiveRecord::Migration
  def change
  	rename_column :orders, :hash, :access
  end
end
