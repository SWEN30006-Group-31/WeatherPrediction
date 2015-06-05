class Observation < ActiveRecord::Base
	belongs_to :source
	belongs_to :location
end