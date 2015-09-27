json.money_receipt do
  json.(@money_receipt, :id, :order_id, :amount, :bank_charge, :date, :attach, :state)
end