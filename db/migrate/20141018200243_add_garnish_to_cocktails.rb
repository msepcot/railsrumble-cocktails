class AddGarnishToCocktails < ActiveRecord::Migration
  def change
    add_column :cocktails, :garnish, :string
  end
end
