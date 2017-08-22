class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :instructions
      t.integer :cooking_time
      t.integer :preparation_time
      t.string :difficulty
      t.string :type
      t.integer :servings
      t.integer :seasonality
      t.boolean :vegan

      t.timestamps
    end
  end
end
