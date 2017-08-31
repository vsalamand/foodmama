class RecipesController < ApplicationController
  before_action :set_recipe, only: [ :show, :upvote, :downvote ]
  skip_before_action :authenticate_user!, only: [ :show ]

  def show
    @dose = Dose.new
  end

  def upvote
    @recipe.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @recipe.downvote_by current_user
    redirect_to :back
  end

  def instruction_lines
    i = 1
    @recipe.instructions.split("\r\n\r\n").each do |line|
      @line = line
      i+=1
    end
  end

  private
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
  def recipe_params
    params.require(:recipe).permit(:name, :photo, :photo_cache, :instructions, :difficulty, :cooking_time, :preparation_time, :recipe_type_list, :diet_list, :season_list)
  end
end
