class Order < ApplicationRecord
    has_many :order_games
    validates :date, presence:true
    validates :status, presence:true
    validates :comments, presence:true
end
