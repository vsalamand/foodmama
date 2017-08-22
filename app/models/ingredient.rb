class Ingredient < ApplicationRecord
  has_many :doses
  validates :name, presence: true, uniqueness: true
  validates :january, presence: true, inclusion: { :in => [0, 50, 100]}
end
