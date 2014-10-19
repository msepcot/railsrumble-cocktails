class IntelligentDesignController < ApplicationController
  def index
    @ingredients = Ingredient.order(:name)
  end

  def concoct
    drinks = Cocktail.requiring(params[:ingredients])

    render json: {
      drinks: drinks, # Returning this in json incase we wanna fuck with it on the front-end.
      html: render_to_string(partial: 'drinks', locals: { drinks: drinks }, layout: false)
    }
  end
end
