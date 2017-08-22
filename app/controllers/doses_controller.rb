class DosesController < ApplicationController
  def create
    @dose = Dose.new(dose_params)
    @recipe = Recipe.find(params[:recipe_id])
    @dose.recipe = @recipe
    if @dose.save
      redirect_to recipe_path(@recipe)
    else
      @ingredients = Ingredient.all
      render 'recipes/show'
    end
  end

  def edit
  @recipe = Recipe.find(params[:recipe_id])
  @dose = Dose.find(params[:id])
  end

  def update
   @dose= Dose.update(dose_params)
   redirect_to recipe_path(@recipe)
  end

  def destroy
    @dose = Dose.find(params[:id]) #get the dose from the id
    @recipe = @dose.recipe
    @dose.destroy
    redirect_to recipe_path(@recipe)
  end

  private

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end





# afficher la liste des doses dans la show de recipes
 #</ul>
#<% @recipe.doses.each do |dose| %>
  #<li><%= link_to dose.ingredient.name, ingredient_path(dose.ingredient) %> : <%= dose.description %> <%= link_to "<i class='fa fa-close'></i>".html_safe, dose_path(dose), method: :delete, data: { confirm: "Are you sure?" } %></li>
  #<% end %>
#</ul>

# ¶
# <% if @dose.errors.any? %>
        #<ul>
          #<% @dose.errors.full_messages.each do |message| %>
            #<li><%= issue %></li>
          #<% end %>
        #</ul>
      #<% end %>



#simple form pour la show de recipes
#<%= simple_form_for([@recipe, @dose]) do |f| %>
        #<%= f.input :description %>
        #<%= f.input :ingredient_id, collection: @ingredients %>
        #<%= f.submit "Add Doses" class: "btn btn-primary" %>
      #<% end %>
#<%= link_to 'Back', recipes_path %>

