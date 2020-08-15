class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.integer :position
      t.date :date
      t.string :transaction_type
      t.text :description
      t.integer :value
      t.integer :balance
      t.string :account_name
      t.string :account_number
      t.references :source, foreign_key: true

      t.timestamps
    end
  end
end
