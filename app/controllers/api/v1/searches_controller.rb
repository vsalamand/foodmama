class Api::V1::SearchesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User #, except: [ :index, :show ]

  def suggest
    @recipes = Recipe.all
    if current_user
      @user = current_user
      @banned_ingredients = @user.find_down_voted_items
    else
      @user = User.last
      @banned_ingredients = []
    end
    @month = Date.today.strftime("%B").downcase
    @month_recipes = @recipes.reject do |recipe|
        (recipe.ingredients & @banned_ingredients).any? || recipe.ingredients.any? { |ingredient| ingredient.send(@month) == 0 }
      end
    if params[:recipes].present?
      @month_recipes = @month_recipes.reject do |recipe|
        params[:recipes].include?(recipe.id.to_s)
      end
    end
    @suggested_recipes = @month_recipes.shuffle.take(2)
    respond_to do |format|
      format.json { render :suggest }
    end
  end

  def search
    # http://localhost:3000/api/v1/search?ingredients[]=tomate&ingredients[]=papier
    @searched_recipes = Recipe.all
    if params[:ingredients].present?
      @searched_recipes = Recipe.search(params[:ingredients]).order("created_at DESC")
    end
    respond_to do |format|
      format.json { render :search }
    end
  end

  def ban_ingredient
    if params[:ingredient].present?
      @ban_ingredient = Ingredient.where("name ILIKE ? ", "#{params[:ingredient]}%").first
      current_user.dislikes @ban_ingredient
    end
    head :ok
  end

end
