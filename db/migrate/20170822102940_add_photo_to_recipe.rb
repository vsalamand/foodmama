class AddPhotoToRecipe < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :photo, :string
  end
end
