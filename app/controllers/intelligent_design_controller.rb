class IntelligentDesignController < ApplicationController
  def index
    @ingredients = Ingredient.find_in_batches(batch_size: 6)
  end

  def concoct
    drinks = Cocktail.requiring(params[:ingredients])

    render json: {
      drinks: drinks, # Returning this in json incase we wanna fuck with it on the front-end.
      html: render_to_string(partial: 'drinks', locals: { drinks: drinks }, layout: false)
    }
  end
end
