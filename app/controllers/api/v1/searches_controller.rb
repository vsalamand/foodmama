class Api::V1::SearchesController < Api::V1::BaseController
  before_action :set_user, only: [:suggest, :ban_ingredient]

  def suggest
    @recipes = Recipe.all
    if current_user
      @user = current_user
      @banned_ingredients = @user.find_down_voted_items
    # else
    #   @user = User.last
    #   @banned_ingredients = []
    end
    @month = Date.today.strftime("%B").downcase
    @month_recipes = @recipes.reject do |recipe|
        (recipe.ingredients & @banned_ingredients).any? || recipe.ingredients.any? { |ingredient| ingredient.send(@month) == 0 }
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

  private

  def set_user
    if (params[:sender_id] && params[:userName])
      first_name = params[:userName].split(' ').first
      last_name  = params[:userName].split(' ').last
      user =  User.find_or_create_by(recast_sender_id: params[:sender_id])
      user.first_name = first_name
      user.last_name  = last_name
      user.save
      current_user = user
    end
  end
end
