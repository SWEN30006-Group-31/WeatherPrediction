# vim:sts=2:sw=2:et

json.array!(@locations) do |loc|
  json.id = loc.name
  json.(loc, :lat, :lon)
  json.last_update = loc.last_update.to_s
end
