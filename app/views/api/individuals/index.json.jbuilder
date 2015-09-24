json.array!(@individuals) do |individual|
  json.(individual, :id, :name)
end