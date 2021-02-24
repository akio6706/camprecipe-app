class RecipeIngredientProcedure
  include ActiveModel::Model
  attr_accessor :image, :title, :description, :people, :level_id, :user_id, :ingredient, :amount, :procedure, :recipe_id

  with_options presence: true do
    validates :image
    validates :title
    validates :description
    validates :people
    validates :user_id
    validates :recipe_id
    validates :ingredient
    validates :amount
    validates :procedure
  end
  validates :area_id, numericality: { other_than: 1 }
  def save
    recipe = Recipe.create(image: image, title: title, description: description, people: people, level_id: level_id, user_id: user_id)
    Ingredient.create(ingredient: ingredient, amount: amount, recipe_id: recipe.id)
    Procedure.create(procedure: procedure, recipe_id: recipe.id)
  end
end