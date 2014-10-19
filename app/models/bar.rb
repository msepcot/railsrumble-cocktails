class Bar < ActiveRecord::Base
  belongs_to :user
  belongs_to :ingredient

  validates_presence_of :user
  validates_presence_of :ingredient
end
