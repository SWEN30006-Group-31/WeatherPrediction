class Source < ActiveRecord::Base
	has_many :observations
	has_many :weather_batches, :through => :observations
	has_many :locations, :through => :observations
end
