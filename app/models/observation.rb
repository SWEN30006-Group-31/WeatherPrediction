class Observation < ActiveRecord::Base
	belongs_to :weather_batch
	belongs_to :source
	belongs_to :location
end