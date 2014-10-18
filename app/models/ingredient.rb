class Ingredient < ActiveRecord::Base
  belongs_to :group

  validates_presence_of :name
end
