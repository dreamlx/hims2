json.product do
  json.(@product, :id, :name, :title4, :content4, :title5, :content5, :title6, :content6, :title7, :content7)
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