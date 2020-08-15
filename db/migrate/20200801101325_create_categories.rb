class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :title
      t.text :description
      t.integer :parent_category_id
      t.string :colour

      t.timestamps
    end
  end
end
