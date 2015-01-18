class AddCityAndStateToWeathers < ActiveRecord::Migration
  def change
    add_column :weathers, :city, :string
    add_column :weathers, :state, :string
  end
end
