json.(order, :id, :amount)
json.investor_name order.investable.name
json.product_id order.product.id
json.product_name order.product.name
json.amount order.amount
json.product_abbr order.product.abbr
json.product_desc order.product.desc
json.currency order.product.currency