class Recipe < ApplicationRecord
  has_many :doses
  has_many :past_recommendations
  acts_as_votable

  mount_uploader :photo, PhotoUploader

  validates :name, presence: true, uniqueness: true
  validates :instructions, :servings, presence: true

  DIFFICULTIES = ["Très facile", "Facile", "Moyen", "Difficile"]
  validates :difficulty, inclusion: { :in => DIFFICULTIES }

  #permet de créer des listes de tags avec la gem act_as_taggable
  acts_as_taggable_on :seasons, :recipe_types, :diets
  #valide qu'un tag est présent dans :recipe_types
  validates :recipe_type_list, presence: true
  #valide que chaque tag ajouté existe dans la constante
  validate :validate_recipe_type, :validate_season_list

  RECIPE_TYPES = ["Apéritif", "Entrée", "Plat", "Accompagnement", "Dessert", "Boisson", "Petit-déjeuner", "Snack"]
  SEASONS = ["Printemps", "Eté", "Automne", "Hiver"]
  DIETS = ["Vegan"]

  #méthodes custom de validation des tags
  def validate_season_list
    season_list.each do |season|
      record.errors[:season_list] << 'Not available!' unless SEASONS.include? season
    end
  end

  def validate_recipe_type
    recipe_type_list.each do |type|
      record.errors[:recipe_type_list] << 'Not available!' unless RECIPE_TYPES.include? type
    end
  end

  def validate_diet_list
    diet_list.each do |diet|
      record.errors[:diet_list] << 'Not available!' unless DIETS.include? diet
    end
  end

  def score
    self.get_upvotes.size - self.get_downvotes.size
  end
end
