class CreateTransactionHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :transaction_histories do |t|
    	t.string :user_id
    	t.string :transaction_type
    	t.string :reference_id
      t.decimal :amount, :precision => 32, :scale => 16
    	t.decimal :current_wallet_balance, :precision => 32, :scale => 16
    	t.string :status


      t.timestamps
    end
  end
end
