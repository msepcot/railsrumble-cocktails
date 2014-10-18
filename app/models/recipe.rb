class Recipe < ActiveRecord::Base
  belongs_to :cocktail
  belongs_to :ingredient

  validates_presence_of :cocktail
  validates_presence_of :ingredient
  validates_presence_of :measurement
end
