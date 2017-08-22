class Dose < ApplicationRecord
  belongs_to :ingredient
  belongs_to :recipe

  validates :description, :ingredient_id, :recipe_id, presence: true

end
