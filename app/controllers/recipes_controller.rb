class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe_ingredient_procedure = RecipeIngredientProcedure.new
  end

  def create
    @recipe_ingredient_procedure = RecipeIngredientProcedure.new(recipe_params)
    if @recipe_ingredient_procedure.valid?
      @recipe_ingredient_procedure.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    
  end

  private

  def recipe_params
    params.require(:recipe_ingredient_procedure).permit(:image, :title, :description, :people, :level_id, :ingredient, :amount,
                                                        :procedure).merge(
                                                          user_id: current_user.id
                                                        )
  end
end
