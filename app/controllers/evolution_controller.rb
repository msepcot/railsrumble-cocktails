class EvolutionController < ApplicationController

  def index
    @base_groups = Group.where(:evolvable => true).to_a
  end

  def evolve
    if(params[:base])
      ing = Ingredient.where(:group_id => params[:base]).to_a.sample
      render json: { drinks: Cocktail.evolve([ing.id]) }
    else
      ings = Cocktail.find(params[:cocktail]).ingredients.map { |i| i.id }
      render json: { drinks: Cocktail.evolve(ings, params[:cocktail]) }
    end
  end
end
