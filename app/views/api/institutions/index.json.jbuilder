json.array!(@institutions) do |institution|
  json.(institution, :id, :name)
  json.booking_count institution.booking_orders.count
  json.holding_count institution.holding_orders.count
end