json.recipes @searched_recipes do |recipe|
  json.title recipe.name
  json.imageUrl recipe.photo_url
  json.recipeUrl recipe_path(recipe)
  json.recipeId recipe.id
  json.servings recipe.servings
  json.ingredients recipe.doses do |dose|
    json.dose dose.description
    json.ingredient dose.ingredient.name
    json.complement  dose.complement
  end
end
