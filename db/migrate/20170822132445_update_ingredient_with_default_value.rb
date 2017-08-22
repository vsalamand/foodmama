class UpdateIngredientWithDefaultValue < ActiveRecord::Migration[5.0]
  def change
    change_column :ingredients, :january, :integer, default: 100
    change_column :ingredients, :february, :integer, default: 100
    change_column :ingredients, :march, :integer, default: 100
    change_column :ingredients, :april, :integer, default: 100
    change_column :ingredients, :may, :integer, default: 100
    change_column :ingredients, :june, :integer, default: 100
    change_column :ingredients, :july, :integer, default: 100
    change_column :ingredients, :august, :integer, default: 100
    change_column :ingredients, :september, :integer, default: 100
    change_column :ingredients, :october, :integer, default: 100
    change_column :ingredients, :november, :integer, default: 100
    change_column :ingredients, :december, :integer, default: 100
  end
end
