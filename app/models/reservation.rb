class Reservation < ApplicationRecord
	belongs_to :bus
	validates :seats,presence: true
end
