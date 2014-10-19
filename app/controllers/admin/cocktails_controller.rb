class Admin::CocktailsController < ApplicationController

  def new
  end

  def create
    Importer.load_string(params[:yaml])
    redirect_to new_admin_cocktail_path, message: 'Success!'
  end

end
