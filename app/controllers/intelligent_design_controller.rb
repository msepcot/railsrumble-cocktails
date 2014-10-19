class IntelligentDesignController < ApplicationController
  def index
    @ingredients = Ingredient.order(:name)
    @saved_ingredients = current_or_guest_user.ingredients.map { |i| i.id }
  end

  def concoct
    drinks = Cocktail.requiring(params[:ingredients])
    ing_ids = params[:ingredients] unless params[:ingredients].blank?
    current_or_guest_user.ingredients = Ingredient.find(ing_ids)
    render json: {
      drinks: drinks, # Returning this in json incase we wanna fuck with it on the front-end.
      html: render_to_string(partial: 'drinks', locals: { drinks: drinks }, layout: false)
    }
  end
end
