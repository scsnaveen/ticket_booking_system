class BusesController < ApplicationController
	# before_action :set_points, only: [:index]
	def index
		@q = Bus.ransack(params[:q])
		@buses = @q.result(distinct: true)
	end

	def new
		@bus = Bus.new
	end

	def create
		@bus =Bus.new(bus_params)
		@bus.available = params[:capacity]
		@bus.reserved =0
		if @bus.save
			redirect_to buses_new_path,notice:"successfully created"
		else
			render "new"
		end
	end

	def show
		@bus = Bus.find(params[:id])
	end
	# def set_points
	# 	@start = params[:starting_point].present?
	# 	@end = params[:destination_point].present?
	# 	if !@start && !@end
	# 		flash[:alert] = "please select start and destination point"
	# 		redirect_to root_path 
	# 	else
	# 		render :index
	# 	end
	# end

	def bus_params
		params.permit(:serial_no,:starting_point,:destination_point,:capacity,:reserved,:available,:fare,:travel_date)
	end
end
