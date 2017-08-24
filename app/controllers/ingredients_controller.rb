class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy, :upvote, :downvote, :score]

  def index
    if params[:search_ingredient].present?
      @ingredients = Ingredient.all
      @ingredients = @ingredients.select { |ingredient| ingredient.name.downcase.include?(params[:search_ingredient].downcase) }
    end
  end

  def show
  end

  # def new
  #   @ingredient = Ingredient.new
  # end

  # def create
  #   @ingredient = Ingredient.new(ingredient_params)
  #   if @ingredient.save
  #     redirect_to :back
  #   else
  #     render :new
  #   end
  # end

  # def edit
  # end

  # def update
  #   @ingredient.update(ingredient_params)
  #   if @ingredient.save
  #     redirect_to ingredient_path(@ingredient)
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   @ingredient.destroy
  #   redirect_to ingredients_path
  # end

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
