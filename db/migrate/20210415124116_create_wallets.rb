class CreateWallets < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets do |t|
      t.decimal :balance, :precision => 32, :scale => 16 
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
