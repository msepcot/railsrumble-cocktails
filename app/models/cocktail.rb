class Cocktail < ActiveRecord::Base
  belongs_to :drinkware

  validates_presence_of :name
  validates_presence_of :instructions
  validates_presence_of :drinkware
  validates_presence_of :served
end
