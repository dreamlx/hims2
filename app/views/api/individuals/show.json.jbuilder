json.individual do
  json.(@individual, :id, :name, :cell, :remark_name, :id_type, :id_no, :id_front, :id_back, :remark)
  json.created_at @individual.created_at.to_date
  json.booking_count @individual.booking_orders.count
  json.holding_count @individual.holding_orders.count
end