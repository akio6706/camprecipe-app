class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.string     :ingredient
      t.string     :amount
      t.integer    :inum
      t.references :recipe,     foreign_key: true
      t.timestamps
    end
  end
end