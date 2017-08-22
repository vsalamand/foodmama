class Ingredient < ApplicationRecord
  has_many :doses, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :january, presence: true, inclusion: { :in => [0, 50, 100]}
  mount_uploader :photo, PhotoUploader
end
