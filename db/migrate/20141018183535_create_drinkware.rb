class CreateDrinkware < ActiveRecord::Migration
  def change
    create_table :drinkwares do |t|
      t.string :name
      t.string :image

      t.timestamps
    end

    add_reference :cocktails, :drinkware, index: true
  end
end
