json.institution do
  json.(@institution, :id, :name, :cell, :remark_name, :organ_reg, :business_licenses, :remark, :state)
  json.created_at @institution.created_at.to_date
  json.booking_count @institution.booking_orders.count
  json.holding_count @institution.holding_orders.count
end