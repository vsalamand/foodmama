class DosesController < ApplicationController

  def create
    @dose = Dose.new(dose_params)
    @recipe = Recipe.find(params[:recipe_id])
    @dose.recipe = @recipe
    @dose.save
    respond_to do |format|
      format.js  # <-- will render `app/views/doses/create.js.erb`
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
    params.require(:dose).permit(:description, :ingredient_id, :complement)
  end
end
