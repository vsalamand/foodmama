class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :upvote, :downvote]

  def show
  end

  def upvote
    @ingredient.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @ingredient.downvote_by current_user
    redirect_to :back
  end

  private

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december, :photo, :photo_cache)
  end
end
