class CreateSources < ActiveRecord::Migration[6.0]
  def change
    create_table :sources do |t|
      t.string :title
      t.text :regex
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
