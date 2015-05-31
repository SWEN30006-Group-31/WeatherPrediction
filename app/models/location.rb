class Location < ActiveRecord::Base
	belongs_to: :postcode
	has_many :observations
end
