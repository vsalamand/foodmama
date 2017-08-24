class UsersController < ApplicationController

  def show
    @user = current_user
    @banned_ingredients = @user.find_down_voted_items

    if params[:search_ingredient].present?
      @ingredients = Ingredient.all
      @ingredients = @ingredients.select { |ingredient| ingredient.name.downcase.include?(params[:search_ingredient].downcase) }
      @ingredients = @ingredients.reject { |ingredient| @banned_ingredients.include?(ingredient) }
    end

    @history_recipes = @user.get_up_voted Recipe
  end
end
