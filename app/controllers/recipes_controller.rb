class RecipesController < ApplicationController
  def index
  end

  def new
    
  end

  def create
    @recipe_ingredient_procedure = RecipeIngredientProcedure.new(recipe_params)
    if @recipe_ingredient_procedure.valid?
      @recipe_ingredient_procedure.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def recipe_params
    params.require(:recipe_ingredient_procedure).permit(:image, :title, :description, :people, :level_id, :ingredient, :amount, :procedure).merge(
      user_id: current_user.id, recipe_id: params[:recipe_id]
    )
  end
end
