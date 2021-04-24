class PaymentsController < ApplicationController
	before_action :authenticate_user!

	def new
		@reservation =Reservation.find(params[:id])
		@bus = Bus.find(@reservation.bus_id)
		@payment = Payment.new
	end

	def create
		@reservation =Reservation.find(params[:id])
		@bus = Bus.find(@reservation.bus_id)
		if @reservation.amount > current_user.wallet.balance
			flash[:alert] ="There was no sufficient money"
			redirect_to payments_new_path(:id=>@reservation.id)
			return
		else
			loop do 
				@payment_reference = ( "Userpayment" + [*(0..9)].sample(10).join.to_s )
				break @payment_reference unless Payment.exists?(payment_reference: @payment_reference)
			end
			@payment 						        = Payment.new
			@payment.user_id 				      	= current_user.id
			@payment.amount      			      	= @reservation.amount
			@payment.payment_reference 	 		 	= @payment_reference
			@payment.reservation_id	          					= @reservation.id
			if @payment.valid?
				@user_wallet  = current_user.wallet
				@admin_wallet 	  = Wallet.find(1)
				@user_wallet.transaction do
					@user_wallet.with_lock do 
						@user_wallet.balance = @user_wallet.balance -  @reservation.amount
						@user_wallet.save
						end
				end
				@admin_wallet.transaction do
					@admin_wallet.with_lock do 
						@admin_wallet.balance = @admin_wallet.balance + @reservation.amount
						@admin_wallet.save
					end
				end
			end
			@admin_payment = TransactionHistory.new(user_id:@admin_wallet.user_id,transaction_type:"credited",amount:@payment.amount,current_wallet_balance: @admin_wallet.balance,reference_id:@payment.payment_reference,status:"success")
			@admin_payment.save
			@bus.available = @bus.available.to_f - @reservation.seats.to_f
			@bus.reserved = @bus.reserved.to_f + @reservation.seats.to_f
			@bus.save
			@payment.status = "paid"
			@payment.save
			redirect_to payments_show_path(:id=> @payment.id),notice:"Happy Journey!"
		end
	end
	
	def refund
		payment = Payment.find(params[:id])
		@reservation = Reservation.find(payment.reservation_id)
		@bus = Bus.find(@reservation.bus_id)
		day_diff = (@bus.travel_date.to_date - Time.now.to_date).to_i
		if @check = Payment.where("payment_reference = ? AND status = ?", payment.payment_reference,"refund").present?
			redirect_to payments_show_path(:id=> payment.id),alert:"Already refunded"
			return
		elsif day_diff < 2
			redirect_to payments_show_path(:id=> payment.id),alert:"Sorry you can't cancel ticket before 2days"
		else
		@fee = PaymentCharge.where("days <= ?",day_diff).first.percentage
		@charges = @fee.to_f / 100 * payment.amount 
			@payment 						        = Payment.new
			@payment.user_id 				      	= current_user.id
			@payment.amount      			      	= payment.amount -  @charges
			@payment.payment_reference 	 		 	= payment.payment_reference
			@payment.reservation_id	          					= payment.reservation_id
			@user_wallet  = current_user.wallet
			@admin_wallet 	  = Wallet.find(1)
			@admin_wallet.transaction do
				@admin_wallet.with_lock do 
					@admin_wallet.balance = @admin_wallet.balance - @payment.amount
					@admin_wallet.save
				end
			end
			@user_wallet.transaction do
				@user_wallet.with_lock do 
					@user_wallet.balance = @user_wallet.balance +  @payment.amount
					@user_wallet.save
				end
			end
		@admin_payment = TransactionHistory.new(user_id:@admin_wallet.user_id,transaction_type:"debited",amount: @payment.amount,refund_fee:@charges,current_wallet_balance: @admin_wallet.balance,reference_id:@payment.payment_reference,status:"success")
		@admin_payment.save
		@bus.available = @bus.available.to_f + @reservation.seats.to_f
		@bus.reserved = @bus.reserved.to_f - @reservation.seats.to_f
		@bus.save
		@payment.status = "refund"
		@payment.save
		redirect_to payments_show_path(:id=> @payment.id)
	end
	end
	def show
		@payment = Payment.find(params[:id])
	end
	def user_payment_histories
		@payments = current_user.payments.all.order("created_at DESC")
	end
end
