class Fix < ActiveRecord::Migration[6.0]
  def change
    rename_column :games, :cat_id, :category_id
  end
end
