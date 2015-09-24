json.array!(@institutions) do |institution|
  json.(institution, :id, :name)
end