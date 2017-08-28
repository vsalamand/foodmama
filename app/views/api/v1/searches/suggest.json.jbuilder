# {
#   type: 'carousel',
#   content: [
#     {
#       title: 'CARD_1_TITLE',
#       imageUrl: 'IMAGE_URL',
#       buttons: [
#         {
#           title: 'BUTTON_1_TITLE',
#           value: 'BUTTON_1_VALUE',
#           type: 'BUTTON_1_TYPE',
#         }
#       ]
#     }
#   ],
# }

# json.type 'carousel'
# json.content @suggested_recipes do |recipe|
#   json.title recipe.name
#   json.imageUrl recipe.photo_url
#   json.buttons do
#     json.child! do
#       json.title 'BUTTON_1_TITLE'
#       json.value 'BUTTON_1_VALUE'
#       json.type  'BUTTON_1_TYPE '
#     end
#   end
# end


json.recipes @suggested_recipes do |recipe|
  json.title recipe.name
  json.imageUrl recipe.photo_url
  json.ingredients recipe.doses do |dose|
    json.dose dose.description
    json.ingredient dose.ingredient.name
    json.complement  dose.complement
  end
end
