class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :name
      t.integer :cat_id
      t.string :image
      t.decimal :price

      t.timestamps
    end
  end
end
