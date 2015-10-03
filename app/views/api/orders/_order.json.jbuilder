json.(order, :id, :amount)
json.investor_name order.investable.name
json.product_name order.product.name
json.amount order.amount