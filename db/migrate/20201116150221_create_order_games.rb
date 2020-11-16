class CreateOrderGames < ActiveRecord::Migration[6.0]
  def change
    create_table :order_games do |t|
      t.id :order
      t.int :product_id
      t.int :qty
      t.int :order_price

      t.timestamps
    end
  end
end
