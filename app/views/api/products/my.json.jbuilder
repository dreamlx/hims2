json.array!(@products) do |product|
  json.(product, :id, :name, :desc, :title1, :content1, :title2, :content2, :title3, :content3, :progress_bar)
  json.orders do
    json.array!(product.orders) do |order|
      json.id order.id
      json.investor_name order.investable.name
      json.currency product.currency
      json.amount order.amount
    end
  end
end