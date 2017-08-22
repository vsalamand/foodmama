class Recipe < ApplicationRecord
  has_many :doses
  has_many :past_recommendations
end
