class ChangeEventTimeToStartsAt < ActiveRecord::Migration
  def change
    rename_column :events, :time, :starts_at
  end
end
