json.booked do
  json.partial! 'api/orders/order', collection: @booked, as: :order
end

json.completed do
  json.partial! 'api/orders/order', collection: @completed, as: :order
end

json.valued do
  json.partial! 'api/orders/order', collection: @valued, as: :order
end