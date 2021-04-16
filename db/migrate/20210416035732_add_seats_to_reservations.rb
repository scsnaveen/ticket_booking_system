class AddSeatsToReservations < ActiveRecord::Migration[6.1]
  def change
  	add_column :reservations,:seats,:integer
  	add_column :buses,:fare,:decimal
  end
end
