json.recipes @history_recipes do |recipe|
  json.title recipe.name
  json.imageUrl recipe.photo_url
  json.recipeUrl recipe_path(recipe)
  json.recipeId recipe.id
end
