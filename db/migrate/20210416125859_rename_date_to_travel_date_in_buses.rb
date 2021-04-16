class RenameDateToTravelDateInBuses < ActiveRecord::Migration[6.1]
  def change
  	rename_column :buses,:date,:travel_date
  	remove_column :reservations,:date
  	remove_reference :payments,:bus
  	add_reference :payments,:reservation, foreign_key: true
  end
end
