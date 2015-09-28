json.array!(@individuals) do |individual|
  json.(individual, :id, :name)
  json.booking_count individual.booking_orders.count
  json.holding_count individual.holding_orders.count
end