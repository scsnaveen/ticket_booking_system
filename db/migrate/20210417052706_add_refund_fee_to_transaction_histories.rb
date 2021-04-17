class AddRefundFeeToTransactionHistories < ActiveRecord::Migration[6.1]
  def change
  	add_column :transaction_histories,:refund_fee,:decimal,:precision => 32, :scale => 16
  end
end
