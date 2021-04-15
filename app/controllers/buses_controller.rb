class BusesController < ApplicationController
	def index
		@buses =Bus.all
	end
	def new
		@bus = Bus.new
	end
	def create
		@bus =Bus.new(bus_params)
		if @bus.save
			redirect_to buses_new_path,notice:"successfully created"
		else
			render "new"
		end
	end

	private
	def bus_params
		params.permit(:serial_no,:starting_point,:destination_point,:capacity,:reserved,:available)
	end
end
