class CreateBuses < ActiveRecord::Migration[6.0]
  def change
    create_table :buses do |t|
      t.string :serial_no
      t.string :starting_point
      t.string :destination_point
      t.integer :capacity
      t.integer :reserved
      t.integer :available

      t.timestamps
    end
  end
end
