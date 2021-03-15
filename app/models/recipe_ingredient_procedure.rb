class RecipeIngredientProcedure
  include ActiveModel::Model
  attr_accessor :image, :title, :description, :people, :level_id, :user_id, :ingredient, :amount, :ingredients, :procedure

  with_options presence: true do
    validates :image
    validates :title
    validates :description
    validates :people
    validates :user_id
    validates :ingredient
    validates :amount
    validates :procedure
  end
  validates :level_id, numericality: { other_than: 1 }

  def save
    recipe = Recipe.new(image: image, title: title, description: description, people: people, level_id: level_id,
                          user_id: user_id)
    if recipe.valid?
      recipe.save
    end

    ingredients.each do |ingredient|
      value = ingredient[1]
      value2 = Ingredient.new(ingredient: value[:ingredient], amount: value[:amount], recipe_id: recipe.id)
      if value2.valid?
        value2.save
      end
    end

    value3 = Procedure.new(procedure: procedure, recipe_id: recipe.id)
    if value3.valid?
      value3.save
    end
  end
  def update
    @recipe.update(image: image, title: title, description: description, people: people, level_id: level_id,
                          user_id: user_id)
  end
end
