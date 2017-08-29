class Api::V1::ActionsController < Api::V1::BaseController
  before_action :set_user, only: [:suggest, :ban_ingredient, :unban_ingredient, :banned_ingredients, :select_recipe, :history]
  before_action :set_banned_ingredients, only: [:suggest, :banned_ingredients]

  def suggest
    # http://localhost:3000/api/v1/suggest?sender_id=1234567890&userName=Guy%20Teub
    @recipes = Recipe.all
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
    # http://localhost:3000/api/v1/search?ingredients[]=tomate&ingredients[]=papier&sender_id=1234567890&userName=Guy%20Teub
    @searched_recipes = []
    if params[:ingredients].present?
      @searched_recipes = Recipe.search(params[:ingredients]).order("created_at DESC")
    end
    respond_to do |format|
      format.json { render :search }
    end
  end

  def ban_ingredient
    # http://localhost:3000/api/v1/ban?ingredient=courgette&sender_id=1234567890&userName=Guy%20Teub
    if params[:ingredient].present?
      ban_ingredient = Ingredient.where("name ILIKE ? ", "#{params[:ingredient]}%").first
      @bot_user.dislikes ban_ingredient
    end
    head :ok
  end

  def unban_ingredient
    # http://localhost:3000/api/v1/unban?ingredient=courgette&sender_id=1234567890&userName=Guy%20Teub
    if params[:ingredient].present?
      unban_ingredient = Ingredient.where("name ILIKE ? ", "#{params[:ingredient]}%").first
      @bot_user.likes unban_ingredient
    end
    head :ok
  end

  def banned_ingredients
    # http://localhost:3000/api/v1/ban?ingredient=courgette&sender_id=1234567890&userName=Guy%20Teub
    respond_to do |format|
      format.json { render :banned_ingredients }
    end
  end

  def select_recipe
    # http://localhost:3000/api/v1/select_recipe?recipe=6&sender_id=1234567890&userName=Guy%20Teub
    if params[:recipe].present?
      recipe = Recipe.where("name ILIKE ? ", "#{params[:recipe]}%").first
      @bot_user.up_votes recipe
    end
    head :ok
  end

  def history
    # http://localhost:3000/api/v1/history?sender_id=1234567890&userName=Guy%20Teub
    if (@bot_user.get_up_voted Recipe).any?
      @history_recipes = @bot_user.get_up_voted Recipe
    else
      @history_recipes = []
    end
    respond_to do |format|
      format.json { render :history }
    end
  end

  private

  def set_user
    if (params[:sender_id] && params[:userName])
      first_name = params[:userName].split(' ').first
      last_name  = params[:userName].split(' ').last
      @bot_user =  User.find_or_create_by(recast_sender_id: params[:sender_id])
      @bot_user.first_name = first_name
      @bot_user.last_name  = last_name
      @bot_user.save
    end
  end

  def set_banned_ingredients
    @bot_user.find_down_voted_items.any? ? @banned_ingredients = @bot_user.find_down_voted_items : @banned_ingredients = []
  end
end
