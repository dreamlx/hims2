json.array!(@products) do |product|
  json.fund_name product.fund.name
  json.(product, :id, :name, :desc, :title1, :content1, :title2, :content2, :title3, :content3, :progress_bar, :label)
end