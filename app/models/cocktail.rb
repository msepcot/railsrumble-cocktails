class Cocktail < ActiveRecord::Base
  belongs_to :drinkware

  has_many :recipes
  has_many :ingredients, through: :recipes

  validates_presence_of :name

  serialize :ingredient_id_array, Array

  before_save :set_ingredient_id_array

  MIN_EVOLUTION_INGREDIENTS_IN_COMMON = 1

  class << self
    def requiring(ingredient_ids)
      return nil if ingredient_ids.blank?
      filter_cocktails(ingredient_ids)
    end

    def evolve(ingredient_ids, from_cocktail_id = nil)
      return nil if ingredient_ids.blank?
      evolve_cocktails(ingredient_ids, from_cocktail_id)
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

    def evolve_cocktails(ingredient_ids, from_cocktail_id)
      evolved = []
      Cocktail.all.each do |candidate|
        in_common = (candidate.ingredient_id_array & ingredient_ids).size
        passes_min_in_common = in_common >= MIN_EVOLUTION_INGREDIENTS_IN_COMMON
        if passes_min_in_common && candidate.id != from_cocktail_id
          evolved << { cocktail: candidate, in_common: in_common, num_ingredients: candidate.ingredient_id_array.size }
        end
      end
      select_evolved_cocktails(evolved)
    end

    def select_evolved_cocktails(evolved_cocktails)
      return evolved_cocktails.map{ |hsh| hsh[:cocktail] } if evolved_cocktails.size <= 3
      selected = get_max_in_common(evolved_cocktails)
      selected = get_min_additional(evolved_cocktails, selected)
      get_random(evolved_cocktails, selected)
    end

    def get_max_in_common(evolved_cocktails)
      sorted = evolved_cocktails.sort_by { |hsh| hsh[:in_common] }.reverse
      [sorted.first[:cocktail]].compact
    end

    def get_min_additional(evolved_cocktails, selected)
      sorted = evolved_cocktails.sort_by { |hsh| hsh[:num_ingredients] }
      if selected.index(sorted.first[:cocktail]).nil?
        selected << sorted.first[:cocktail]
      else
        selected << sorted.second[:cocktail]
      end
      selected
    end

    def get_random(evolved_cocktails, selected)
      return selected if evolved_cocktails.size <= selected.size
      while true
        sampled = evolved_cocktails.sample
        if selected.index(sampled[:cocktail]).nil?
          selected << sampled[:cocktail]
          return selected
        end
      end
    end

  end

  def set_ingredient_id_array
    current_ingredient_array = []
    ingredients.each do |ingredient|
      current_ingredient_array << ingredient.id
    end
    self.ingredient_id_array = current_ingredient_array
  end

end
