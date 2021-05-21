class RecipeIngredientProcedure
  include ActiveModel::Model
  attr_accessor :image, :title, :description, :people, :level_id, :user_id, :procedure, :procedures, :ingredient, :amount,
                :ingredients, :recipe_id, :inum, :pnum

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
    recipe.save if recipe.valid?

    ingredients.each_with_index do |ingredient,i|
      value = ingredient[1]
      value2 = Ingredient.new(ingredient: value[:ingredient], amount: value[:amount],inum: i, recipe_id: recipe.id)
      value2.save if value2.valid?
    end

    procedures.each_with_index do |procedure,i|
      value3 = procedure[1]
      value4 = Procedure.new(procedure: value3[:procedure],pnum: i, recipe_id: recipe.id)
      value4.save if value4.valid?
    end
  end

  def update
    recipe = Recipe.find(recipe_id)
    recipe.update(image: image, title: title, description: description, people: people, level_id: level_id,
                  user_id: user_id)

    ingredients.each_with_index do |ingredient,i|
      value5 = ingredient[1]
      value6 = Ingredient.find_by(recipe_id: recipe.id, inum: i)
      value6.update(ingredient: value5[:ingredient], amount: value5[:amount],inum: i, recipe_id: recipe.id)
    end
    
    procedures.each_with_index do |procedure,i|
      value7 = procedure[1]
      value8 = Procedure.find_by(recipe_id: recipe.id, pnum: i)
      value8.update(procedure: value7[:procedure],pnum: i, recipe_id: recipe.id)
    end
  end
end
