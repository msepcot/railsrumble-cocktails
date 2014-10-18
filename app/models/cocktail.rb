class Cocktail < ActiveRecord::Base
  belongs_to :drinkware

  has_many :recipes
  has_many :ingredients, through: :recipes

  validates_presence_of :name
  validates_presence_of :instructions
  validates_presence_of :drinkware
  validates_presence_of :served

  serialize :ingredient_id_array, Array

  before_save :set_ingredient_id_array

private

  def set_ingredient_id_array
    current_ingredient_array = []
    ingredients.each do |ingredient|
      current_ingredient_array << ingredient.id
    end
    self.ingredient_id_array = current_ingredient_array
  end

end
