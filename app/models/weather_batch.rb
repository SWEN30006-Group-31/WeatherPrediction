class WeatherBatch < ActiveRecord::Base
	has_many :observations, dependent: :destroy
	has_many :locations, :through => :observations
	has_many :sources, :through => :observations
end
