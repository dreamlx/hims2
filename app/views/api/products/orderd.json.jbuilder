json.product do
  json.id @product.id
  json.name @product.name
  json.sales_period @product.sales_period
  json.block_period @product.block_period
  json.paid @product.paid
  json.notices do
    json.array!(@notices) do |attach|
      json.(attach, :id, :title, :attach)
      json.date attach.updated_at.to_date
    end
  end
  json.reports do
    json.array!(@reports) do |attach|
      json.(attach, :id, :title, :attach)
      json.date attach.updated_at.to_date
    end
  end
end