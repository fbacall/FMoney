class CreateRules < ActiveRecord::Migration[6.0]
  def change
    create_table :rules do |t|
      t.references :source, null: false, foreign_key: true
      t.string :field
      t.text :regex

      t.timestamps
    end
  end
end
