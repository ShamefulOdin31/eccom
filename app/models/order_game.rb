class OrderGame < ApplicationRecord
  has_many :orders
  has_many :games
end
