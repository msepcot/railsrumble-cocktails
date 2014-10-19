class IntelligentDesignController < ApplicationController

  def index
    @ingredients = Ingredient.find_in_batches(batch_size: 6)
  end

  def concoct
    render json: Cocktail.requiring(params[:ingredients])
  end

end
