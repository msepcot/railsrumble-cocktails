class Admin::IngredientsController < ApplicationController

  def index
  end

  def show
  end

  def new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)

    @ingredient.save ? redirect_to(admin_ingredients_path) : render(:new)
  end

  def edit
  end

  def update
    ingredient.update_attributes(ingredient_params) ? redirect_to(admin_ingredients_path) : render(:edit)
  end

private

  def ingredient_params
    params.require(:ingredient).permit(:name, :group_id)
  end

  def ingredient
    @ingredient ||= params[:id].present? ? Ingredient.find(params[:id]) : Ingredient.new
  end
  helper_method :ingredient

  def ingredients
    @ingredients ||= Ingredient.order(:name).page(params[:page])
  end

  helper_method :ingredients
end
