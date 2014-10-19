class EvolutionController < ApplicationController

  def index
    @base_groups = Group.where(:evolvable => true).to_a
  end

  def evolve
    if(params[:base])
      ing    = Ingredient.where(:group_id => params[:base]).to_a.sample
      drinks = Cocktail.evolve([ing.id])

      render json: {
        drinks: drinks,
        html: render_to_string(partial: 'evolution', locals: { drinks: drinks }, layout: false)
      }
    else
      ings   = Cocktail.find(params[:cocktail]).ingredients.map { |i| i.id }
      drinks = Cocktail.evolve(ings, params[:cocktail])

      render json: {
        drinks: drinks,
        html: render_to_string(partial: 'evolution', locals: { drinks: drinks }, layout: false)
      }
    end
  end
end
