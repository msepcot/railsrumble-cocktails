class Recipe < ActiveRecord::Base
  belongs_to :cocktail
  belongs_to :ingredient
end
