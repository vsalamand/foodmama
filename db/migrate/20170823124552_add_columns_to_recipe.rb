class AddColumnsToRecipe < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :vegan, :boolean, null: false, default: false
    add_column :recipes, :aperitif, :boolean, null: false, default: false
    add_column :recipes, :entree, :boolean, null: false, default: false
    add_column :recipes, :plat, :boolean, null: false, default: false
    add_column :recipes, :accompagnement, :boolean, null: false, default: false
    add_column :recipes, :dessert, :boolean, null: false, default: false
    add_column :recipes, :boisson, :boolean, null: false, default: false
    add_column :recipes, :petitdejeuner, :boolean, null: false, default: false
    add_column :recipes, :snack, :boolean, null: false, default: false
    add_column :recipes, :printemps, :boolean, null: false, default: false
    add_column :recipes, :ete, :boolean, null: false, default: false
    add_column :recipes, :automne, :boolean, null: false, default: false
    add_column :recipes, :hiver, :boolean, null: false, default: false
  end
end
