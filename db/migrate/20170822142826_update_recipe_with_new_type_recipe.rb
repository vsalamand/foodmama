class UpdateRecipeWithNewTypeRecipe < ActiveRecord::Migration[5.0]
  def change
    rename_column :recipes, :type, :recipe_type
  end
end
