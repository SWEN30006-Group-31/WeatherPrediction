# vim:sts=2:sw=2:et

class Observation < ActiveRecord::Base
  belongs_to :source
  belongs_to :location
end
