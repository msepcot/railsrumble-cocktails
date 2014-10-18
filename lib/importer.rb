class Importer

  class << self
    def import(filepath)
      to_import = YAML.load_file(filepath)
      to_import.each do |importing|
        next unless Cocktail.where(name: importing[:name]).first.nil?

        c = Cocktail.create(name: importing[:name],
          instructions: importing[:preparation],
          served: importing[:served],
          drinkware: find_or_create_drinkware(importing[:drinkware]),
          garnish: importing[:garnish]
        )

        associate_ingredients(c, importing[:ingredients])
      end
    end

  private

    def find_or_create_drinkware(name)
      drinkware = Drinkware.where(name: name).first
      return drinkware unless drinkware.nil?
      Drinkware.create(name: name)
    end

    def associate_ingredients(cocktail, ingredients)
      ingredients.each do |ingredient|
        i = find_or_create_ingredient(ingredient[:name])
        Recipe.create(cocktail: cocktail, ingredient: i, measurement: ingredient[:amount])
      end
    end

    def find_or_create_ingredient(name)
      ingredient = Ingredient.where(name: name).first
      return ingredient unless ingredient.nil?
      Ingredient.create(name: name)
    end
  end
end
