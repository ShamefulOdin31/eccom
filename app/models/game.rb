class Game < ApplicationRecord
    has_many: order_games
    belongs_to: category
end
