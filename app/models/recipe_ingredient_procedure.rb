class RecipeIngredientProcedure
  include ActiveModel::Model
  attr_accessor :image, :title, :description, :people, :level_id, :user_id, :procedure, :procedures, :ingredient, :amount, :ingredients

  with_options presence: true do
    validates :image
    validates :title
    validates :description
    validates :people
    validates :user_id
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

    procedures.each do |procedure|
      value3 = procedure[1]
      value4 = Procedure.new(procedure: value3[:procedure], recipe_id: recipe.id)
      if value4.valid?
        value4.save
      end
    end
  end
  def update
    @recipe.update(image: image, title: title, description: description, people: people, level_id: level_id,
                          user_id: user_id)
  end
end
