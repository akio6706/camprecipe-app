class CreateProcedures < ActiveRecord::Migration[6.0]
  def change
    create_table :procedures do |t|
      t.text       :procedure, null: false
      t.references :recipe,    foreign_key: true
      t.timestamps
    end
  end
end