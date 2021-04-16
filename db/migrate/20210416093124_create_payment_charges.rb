class CreatePaymentCharges < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_charges do |t|
    	t.integer :days
    	t.integer :percentage

      t.timestamps
    end
  end
end
