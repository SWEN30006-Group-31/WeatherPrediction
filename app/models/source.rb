# vim:sts=2:sw=2:et

class Source < ActiveRecord::Base
  has_many :observations
  has_many :locations, :through => :observations
  has_many :postcodes, :through => :observations
end
