json.ingredients @banned_ingredients do |ingredient|
  json.title ingredient.name
  json.imageUrl ingredient.photo_url
end
