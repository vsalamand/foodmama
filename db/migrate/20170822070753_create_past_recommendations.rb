class CreatePastRecommendations < ActiveRecord::Migration[5.0]
  def change
    create_table :past_recommendations do |t|
      t.date :date
      t.references :recipe, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
