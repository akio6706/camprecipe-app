class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @recipes = Recipe.includes(:user)

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

  def edit
    @recipe = Recipe.find(params[:id])
    @recipe_ingredient_procedure = RecipeIngredientProcedure.new
  end

  def update
    @recipe = Recipe.find(params[:id])
    
    @recipe_ingredient_procedure = RecipeIngredientProcedure.new(recipe_params)
    if @recipe_ingredient_procedure.valid?
      @recipe_ingredient_procedure.update
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to root_path
  end
  private

  def recipe_params
    params.require(:recipe_ingredient_procedure).permit(:image, :title, :description, :people, :level_id,
                                                        :procedure, :ingredient, :amount, ingredients: [:ingredient, :amount]).merge(
                                                        user_id: current_user.id
                                                        )
  end
end
