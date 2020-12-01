class Game < ApplicationRecord
  has_many :order_games
  belongs_to :category
  validates :name, presence: true, uniqueness: true
  validates :image, presence: true
  validates :price, presence: true
end
