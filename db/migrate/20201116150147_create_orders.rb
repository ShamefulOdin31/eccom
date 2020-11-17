class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.datetime :date
      t.integer :status
      t.text :comments

      t.timestamps
    end
  end
end
