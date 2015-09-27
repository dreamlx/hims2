json.order do
  json.(@order, :id, :investable_id, :investable_type, :product_id, :user_id, :amount, :due_date, :mail_address, :other, :remark, :state)
end
json.money_receipts do
  json.array!(@order.money_receipts) do |receipt|
    json.(receipt, :id, :amount, :bank_charge, :date, :attach, :state)
  end
end