class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
    	t.references :user, null: false, foreign_key: true
    	t.string     :reservation_number 
    	t.string     :date
    	t.decimal    :amount, :precision => 32, :scale => 16 , null: false
    	t.string     :status

      t.timestamps
    end
  end
end
