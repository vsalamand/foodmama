class Ingredient < ApplicationRecord
  has_many :doses, dependent: :destroy
end
