json.order do
  json.(@order, :id, :investable_id, :investable_type, :product_id, :user_id, :amount, :due_date, :mail_address, :other, :remark, :state, :booking_date, :deliver)
  json.investor_name @order.investable.name
  json.product_name @order.product.name
  json.currency @order.product.currency
  json.product_condition @order.product.condition if @order.product
  if @order.investable_type == "Individual"
    json.number @order.investable.id_no
  elsif @order.investable_type == "Institution"
    json.number @order.investable.organ_reg
  elsif @order.investable_type == "User"
    json.number @order.investable.card_no
  end
end
json.money_receipts do
  json.array!(@order.money_receipts) do |receipt|
    json.(receipt, :id, :amount, :bank_charge, :date, :attach, :state)
  end
end
json.pictures do
  json.array!(@order.pictures) do |picture|
    json.(picture, :id, :title, :pic, :state)
  end
end