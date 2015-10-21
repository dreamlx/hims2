json.array!(@orders) do |order|
  json.product_id order.product_id
  json.product_name order.product.name
  json.product_desc order.product.desc
  json.id order.id
  json.title1 order.product.title1
  json.content1 order.product.content1
  json.title2 order.product.title2
  json.content2 order.product.content2
  json.title3 order.product.title3
  json.content3 order.product.content3
  json.amount order.amount
  json.state order.state
end