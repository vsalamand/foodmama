class Recipe < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :past_recommendations, dependent: :destroy
  has_many :ingredients, through: :doses

  acts_as_votable
  # pour la gem like et dislike

  mount_uploader :photo, PhotoUploader

  validates :name, presence: true, uniqueness: true
  validates :instructions, :servings, presence: true

  # DIFFICULTIES = ["Très facile", "Facile", "Moyen", "Difficile"]
  #commenté pour supprimer la validation de la présence
  # validates :difficulty, inclusion: { :in => DIFFICULTIES }

  #permet de créer des listes de tags avec la gem act_as_taggable
  acts_as_taggable_on :seasons, :recipe_types, :diets
  #valide qu'un tag est présent dans :recipe_types
  # validates :recipe_type_list, presence: true
  #valide que chaque tag ajouté existe dans la constante
  # validate :validate_recipe_type, :validate_season_list

  RECIPE_TYPES = ["Apéritif", "Entrée", "Plat", "Accompagnement", "Dessert", "Boisson", "Petit-déjeuner", "Snack"]
  SEASONS = ["Printemps", "Eté", "Automne", "Hiver"]
  DIETS = ["Vegan"]

  #méthodes custom de validation des tags
  def validate_season_list
    season_list.each do |season|
      errors.add(:season_list, "Season tag not available!") unless SEASONS.include? season
    end
  end

  def validate_recipe_type
    recipe_type_list.each do |type|
      errors.add(:recipe_type_list, "Recipe type tag not available!") unless RECIPE_TYPES.include? type
    end
  end

  def validate_diet_list
    diet_list.each do |diet|
      errors.add(:diet_list, "Diet tag not available!") unless DIETS.include? diet
    end
  end

  def score
    self.get_upvotes.size - self.get_downvotes.size
  end

  def self.search(ingredients)
    query_array = []
    query_hash ={}
    ingredients.each_with_index do |ingredient, index|
      query_array << "ingredients.name ILIKE :ingredient_#{index} OR recipes.name ILIKE :ingredient_#{index} OR recipes.instructions ILIKE :ingredient_#{index}"
      query_hash["ingredient_#{index}".to_sym] = "%#{ingredient}%"
    end

    joins(:ingredients).where(query_array.join(' OR '), query_hash).uniq
  end
end
