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
    @comment = Comment.new
    @comments = @recipe.comments.includes(:user)
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @recipe_ingredient_procedure = RecipeIngredientProcedure.new
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe_ingredient_procedure = RecipeIngredientProcedure.new(recipe_update_params)
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

  def level1
    @recipe1 = Recipe.where(level_id: 2)
  end
  def level2
    @recipe2 = Recipe.where(level_id: 3)
  end
  def level3
    @recipe3 = Recipe.where(level_id: 4)
  end

  def search
    @recipe = Recipe.search(params[:keyword])
  end

  private

  def recipe_params
    params.require(:recipe_ingredient_procedure).permit(:image, :title, :description, :people, :level_id,
                                                        :ingredient, :amount, :procedure, ingredients: [:ingredient, :amount], procedures: [:procedure]).merge(
                                                          user_id: current_user.id
                                                        )
  end
  def recipe_update_params
    params.require(:recipe_ingredient_procedure).permit(:image, :title, :description, :people, :level_id,
                                                        :ingredient, :amount, :procedure, ingredients: [:ingredient, :amount], procedures: [:procedure]).merge(
                                                          user_id: current_user.id, recipe_id: @recipe.id
                                                        )
  end
end
