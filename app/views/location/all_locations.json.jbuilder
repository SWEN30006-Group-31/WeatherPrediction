# vim:sts=2:sw=2:et

json.array!(@locations) do |loc|
  json.(loc, :name, :lat, :lon, :active)
  json.(loc.postcode, :code)
end
