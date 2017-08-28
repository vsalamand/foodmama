class Api::V1::SearchesController < Api::V1::BaseController
  def suggest
    @recipes = Recipe.all
    @user = current_user
    @banned_ingredients = @user.find_down_voted_items
    @month = Date.today.strftime("%B").downcase
    @month_recipes = @recipes.reject do |recipe|
        (recipe.ingredients & @banned_ingredients).any? || recipe.ingredients.any? { |ingredient| ingredient.send(@month) == 0 }
      end
    @suggested_recipes = @month_recipes.shuffle.take(2)
    respond_to do |format|
      # format.html
      format.json { render :suggest }
    end
  end

  def search
    @recipes = Recipe.all
    if params[:query].present?
      @search = Recipe.search(params[:query]).order("created_at DESC")
    end
  end
end
