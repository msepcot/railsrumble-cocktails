class Ingredient < ActiveRecord::Base
  belongs_to :group

  has_many :recipes
  has_many :cocktails, through: :recipes

  validates_presence_of :name
end
