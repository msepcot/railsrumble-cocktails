module IntelligentDesignHelper
  def saved_ingredient?(ing_id)
    return @saved_ingredients.include? ing_id unless @saved_ingredients.blank?
  end
end
