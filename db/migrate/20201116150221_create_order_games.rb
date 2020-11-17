class CreateOrderGames < ActiveRecord::Migration[6.0]
  def change
    create_table :order_games do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :qty
      t.integer :order_price

      t.timestamps
    end
  end
end
