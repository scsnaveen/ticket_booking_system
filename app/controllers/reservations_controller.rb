class ReservationsController < ApplicationController
	def create
		@bus= Bus.find(params[:id])
		if @bus.available == 0
			flash[:notice] ="sorry tickets are filled"
		else
			@reservation = Reservation.new(reservation_params)
		end
	end
	
	private
	def reservation_params
		params.require(:reservation).permit(:user_id,:reservation_no,:date,:amount,:status)
	end
end
