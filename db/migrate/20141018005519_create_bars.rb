class CreateBars < ActiveRecord::Migration
  def change
    create_table :bars do |t|
      t.belongs_to :user, index: true
      t.belongs_to :ingredient, index: true

      t.timestamps
    end
  end
end
