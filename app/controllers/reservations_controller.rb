class ReservationsController < ApplicationController
	before_action :authenticate_user!
	def new
		@bus =Bus.find(params[:id])
		@reservation = Reservation.new
	end

	def create
		@bus = Bus.find(params[:id])
		if @bus.available == 0
			flash[:notice] ="Sorry tickets are filled"
			return
		else 
			@reservation = Reservation.new(reservation_params)
			loop do 
				@reservation.reservation_number = ( [*("A".."Z")].sample(3).join.to_s + [*(0..9)].sample(4).join.to_s )
				break @reservation.reservation_number unless Reservation.exists?(reservation_number: @reservation.reservation_number)
			end
			@reservation.amount = params[:seats].to_f * @bus.fare.to_f
			@reservation.bus_id = @bus.id
			@reservation.save!
			redirect_to payments_new_path(:id=>@reservation.id)
		end
	end

	private
	def reservation_params
		params.permit(:bus_id,:reservation_number,:amount,:status,:seats)
	end
end
