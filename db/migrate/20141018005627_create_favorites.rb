class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.belongs_to :user, index: true
      t.belongs_to :cocktail, index: true
      t.integer :order

      t.timestamps
    end
  end
end
