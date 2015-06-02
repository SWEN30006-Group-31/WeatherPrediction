class Postcode < ActiveRecord::Base
	has_many :locations
	has_many :observations, :through => :locations
end
