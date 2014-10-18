class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :image
      t.belongs_to :group, index: true

      t.timestamps
    end
  end
end
