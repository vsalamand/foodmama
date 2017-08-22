class RemoveSeasonsTypesVeganfromRecipes < ActiveRecord::Migration[5.0]
  def change
    remove_column :recipes, :recipe_type
    remove_column :recipes, :seasonality
    remove_column :recipes, :vegan
  end
end
