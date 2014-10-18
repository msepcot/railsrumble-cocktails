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

  class << self
    def requiring(ingredient_ids)
      return nil if ingredient_ids.blank?
      filter_cocktails(ingredient_ids)
    end

  private

    def filter_cocktails(ingredient_ids)
      filtered = []
      Cocktail.all.each do |candidate|
        is_a_subset = (candidate.ingredient_id_array & ingredient_ids).size.eql?(candidate.ingredient_id_array.size)
        filtered << candidate if is_a_subset
      end
      filtered
    end
  end

private

  def set_ingredient_id_array
    current_ingredient_array = []
    ingredients.each do |ingredient|
      current_ingredient_array << ingredient.id
    end
    self.ingredient_id_array = current_ingredient_array
  end

end
