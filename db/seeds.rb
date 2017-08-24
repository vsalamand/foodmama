require 'open-uri'
require 'nokogiri'
require 'json'
require_relative '../app/models/ingredient'

# CREATING INGREDIENT JSON
# filepath = "ingredients.json"
ingredient_path = "ingredients.json"
recipes_path = "db/recipes.json"
doses_path = "db/doses.json"
# url_base = "http://www.lesfruitsetlegumesfrais.com"
# url = "#{url_base}/fruits-legumes/liste?fp1=&fp2="

# html_file = open(url).read
# html_doc = Nokogiri::HTML(html_file)

# i = 0

# ingredients = { ingredients: []}

# html_doc.search('.item a').each do |item|
#   item_link = item.attribute('href')
#   item_url = "#{url_base}#{item_link}"

#   item_html_file = open(item_url).read
#   item_html_doc = Nokogiri::HTML(item_html_file)

#   ingredient_hash = {}
#   ingredient_hash[:name] = item_html_doc.search(".h1-like").text
#   photo_url_ext = item_html_doc.search(".header-product a img").attribute('src').value
#   ingredient_hash[:photo_url] = "#{url_base}/#{photo_url_ext}"

#   months_weight = []
#   calendar = item_html_doc.search('.bar-calendar dd img').each do |month|
#     if month.attribute('src').value == "images/common/bar-P.gif"
#       months_weight << 100
#     elsif month.attribute('src').value == "images/common/bar-D.gif"
#       months_weight << 50
#     else
#       months_weight << 0
#     end
#   end

#   ingredient_hash[:february]  = months_weight[0]
#   ingredient_hash[:march]     = months_weight[1]
#   ingredient_hash[:april]     = months_weight[2]
#   ingredient_hash[:may]       = months_weight[3]
#   ingredient_hash[:june]      = months_weight[4]
#   ingredient_hash[:july]      = months_weight[5]
#   ingredient_hash[:august]    = months_weight[6]
#   ingredient_hash[:september] = months_weight[7]
#   ingredient_hash[:october]   = months_weight[8]
#   ingredient_hash[:november]  = months_weight[9]
#   ingredient_hash[:december]  = months_weight[10]
#   ingredient_hash[:january]   = months_weight[11]
#   ingredients[:ingredients] << ingredient_hash
#   p ingredients
#   p i+=1
# end

# File.open(filepath, 'wb') do |file|
#   file.write(JSON.generate(ingredients))
# end
puts "starts destroying"

Dose.destroy_all
Ingredient.destroy_all
Recipe.destroy_all

puts "starts creating"

#seed des recipes

serialized_recipes = File.read(recipes_path)

recipes = JSON.parse(serialized_recipes)

recipes.each do |recipe|
  recipe_temp = Recipe.new
  recipe_temp.name = recipe["name"]
  recipe_temp.instructions = recipe["instructions"]
  recipe_temp.cooking_time = recipe["cooking_time"].to_i
  recipe_temp.preparation_time = recipe["preparation_time"].to_i
  recipe_temp.difficulty = recipe["difficulty"].to_i
  recipe_temp.servings = recipe["servings"].to_i
  recipe_temp.remote_photo_url = "https://upload.wikimedia.org/wikipedia/commons/1/14/Pot_au_feu2.jpg" #recipe["photo"]["photo"]["url"]
  recipe_temp.vegan = recipe["vegan"] == "true"
  recipe_temp.aperitif= recipe["aperitif"] == "true"
  recipe_temp.entree = recipe["entree"] == "true"
  recipe_temp.plat = recipe["plat"] == "true"
  recipe_temp.accompagnement = recipe["accompagnement"] == "true"
  recipe_temp.dessert = recipe["dessert"] == "true"
  recipe_temp.boisson = recipe["boisson"] == "true"
  recipe_temp.petitdejeuner = recipe["petitdejeuner"] == "true"
  recipe_temp.snack = recipe["snack"] == "true"
  recipe_temp.printemps = recipe["printemps"] == "true"
  recipe_temp.ete = recipe["ete"] == "true"
  recipe_temp.automne = recipe["automne"] == "true"
  recipe_temp.hiver = recipe["hiver"] == "true"
  # recipe_temp.id = recipe["id"]

  recipe_temp.save
end


#seed des ingrédients

serialized_ingredients = File.read(ingredient_path)

ingredients = JSON.parse(serialized_ingredients)

ingredients["ingredients"].each do |ingredient|
  ingredient_temp = Ingredient.new
  ingredient_temp.name = ingredient["name"]
  ingredient_temp.remote_photo_url = ingredient["photo_url"]
  # ingredient_temp.id = ingredient["id"]

  ingredient_temp.january   = ingredient["january"]
  ingredient_temp.february  = ingredient["february"]
  ingredient_temp.march     = ingredient["march"]
  ingredient_temp.april     = ingredient["april"]
  ingredient_temp.may       = ingredient["may"]
  ingredient_temp.june      = ingredient["june"]
  ingredient_temp.july      = ingredient["july"]
  ingredient_temp.august    = ingredient["august"]
  ingredient_temp.september = ingredient["september"]
  ingredient_temp.october   = ingredient["october"]
  ingredient_temp.november  = ingredient["november"]
  ingredient_temp.december  = ingredient["december"]

  ingredient_temp.save unless ingredient_temp.name == "Fruits exotiques"
end


#seed des doses

# serialized_doses = File.read(doses_path)

# doses = JSON.parse(serialized_doses)
# doses.each do |dose|
#   dose_temp = Dose.new
#   dose_temp.description = dose["description"]
#   dose_temp.ingredient_id = dose["ingredient"]["id"]
#   dose_temp.recipe_id = dose["recipe"]["id"]
#   dose_temp.complement = dose["complement"]
#   dose_temp.ingredient = Ingredient.find(dose_temp.ingredient_id)
#   dose_temp.recipe = Recipe.find(dose_temp.recipe_id)

#   dose_temp.save
# end

