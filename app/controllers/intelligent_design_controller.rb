class IntelligentDesignController < ApplicationController

  def index
    @ingredients = Ingredient.find_in_batches(batch_size: 6)
  end

end
