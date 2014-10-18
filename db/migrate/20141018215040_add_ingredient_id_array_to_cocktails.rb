class AddIngredientIdArrayToCocktails < ActiveRecord::Migration
  def change
    add_column :cocktails, :ingredient_id_array, :text
  end
end
