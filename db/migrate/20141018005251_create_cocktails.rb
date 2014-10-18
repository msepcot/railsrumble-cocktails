class CreateCocktails < ActiveRecord::Migration
  def change
    create_table :cocktails do |t|
      t.string :name
      t.string :image
      t.text :instructions

      t.timestamps
    end
  end
end
