class User < ActiveRecord::Base

  has_many :bars, dependent: :destroy
  has_many :ingredients, through: :bars

  def self.new_guest
    new { |u| u.guest = true }
  end

  def name
    guest ? "Guest" : username
  end
end
