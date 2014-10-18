class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.belongs_to :cocktail, index: true
      t.belongs_to :ingredient, index: true
      t.string :measurement

      t.timestamps
    end
  end
end
