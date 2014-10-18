class AddServedToCocktails < ActiveRecord::Migration
  def change
    add_column :cocktails, :served, :string
  end
end
