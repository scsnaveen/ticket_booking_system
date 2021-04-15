class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
    	t.references :user, null: false, foreign_key: true
    	t.decimal :amount, :precision => 32, :scale => 16 , null: false
    	t.string :status, default: "pending"
    	t.string :payment_reference

      t.timestamps
    end
  end
end
