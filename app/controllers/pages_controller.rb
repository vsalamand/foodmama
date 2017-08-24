class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def suggest
    @recipes = Recipe.all.shuffle.take(2)
  end
end
