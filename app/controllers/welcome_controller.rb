class WelcomeController < ApplicationController
	def index
		@q = Bus.ransack(params[:q])
		@buses = @q.result(distinct: true)
	end
end
