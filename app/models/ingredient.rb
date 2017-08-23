class Ingredient < ApplicationRecord
  has_many :doses
  acts_as_votable

  validates :name, presence: true, uniqueness: true

  validates :january, presence: true, inclusion: { :in => [0, 50, 100] }
  validates :february, presence: true, inclusion: { :in => [0, 50, 100] }
  validates :march, presence: true, inclusion: { :in => [0, 50, 100] }
  validates :april, presence: true, inclusion: { :in => [0, 50, 100] }
  validates :may, presence: true, inclusion: { :in => [0, 50, 100] }
  validates :june, presence: true, inclusion: { :in => [0, 50, 100] }
  validates :july, presence: true, inclusion: { :in => [0, 50, 100] }
  validates :august, presence: true, inclusion: { :in => [0, 50, 100] }
  validates :september, presence: true, inclusion: { :in => [0, 50, 100] }
  validates :october, presence: true, inclusion: { :in => [0, 50, 100] }
  validates :november, presence: true, inclusion: { :in => [0, 50, 100] }
  validates :december, presence: true, inclusion: { :in => [0, 50, 100] }

  mount_uploader :photo, PhotoUploader

  def score
    self.get_upvotes.size - self.get_downvotes.size
  end
end
