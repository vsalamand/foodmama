class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def suggest
    @recipes = Recipe.all.shuffle.take(2)
  end

  def search
    @recipes = Recipe.all
    if params[:query].present?
      @search = Recipe.search(params[:query]).order("created_at DESC")
    end
  end
end
