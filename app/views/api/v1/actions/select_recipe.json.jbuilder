json.title @select_recipe.name
json.imageUrl @select_recipe.photo_url
json.recipeUrl recipe_path(@select_recipe)
json.recipeId @select_recipe.id
json.servings @select_recipe.servings
json.ingredients @select_recipe.doses do |dose|
  json.dose dose.description
  json.ingredient dose.ingredient.name
  json.complement  dose.complement
end

