class RecipesController < ApplicationController
    before_action :set_recipe, only: [:show, :edit, :destroy, :upvote, :downvote]

  # def index
  #   @recipes = Recipe.all
  # end

  def show
    @dose = Dose.new
  end

  # def new
  #   @recipe= Recipe.new
  # end

  # def create
  #   @recipe= Recipe.new(recipe_params)
  #   if @recipe.save
  #     redirect_to recipe_path(@recipe)
  #   else
  #     render :new
  #   end
  # end

  # def edit
  # end

  # def update
  #   @recipe= Recipe.update(recipe_params)
  #   redirect_to recipe_path(@recipe)
  # end

  # def destroy
  #   @recipe.destroy
  #    redirect_to recipes_path
  # end

  def upvote
    @recipe.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @recipe.downvote_by current_user
    redirect_to :back
  end

  private
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
  def recipe_params
    params.require(:recipe).permit(:name, :photo, :photo_cache, :instructions, :difficulty, :cooking_time, :preparation_time, :recipe_types, :diets, :seasons)
  end
end
