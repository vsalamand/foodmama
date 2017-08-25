json.array! @suggested_recipes do |recipe|
  json.extract! recipe, :id
end
