class ReservationsController < ApplicationController
	def create
		@reservation = Reservation.new(reservation_params)
	end
	private
	def reservation_params
		params.require(:reservation).permit(:user_id,:reservation_no,:date,:amount,:status)
	end
end
