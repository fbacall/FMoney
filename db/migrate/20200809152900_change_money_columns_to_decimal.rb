class ChangeMoneyColumnsToDecimal < ActiveRecord::Migration[6.0]
  def up
    change_column :transactions, :balance, :decimal, precision: 8, scale: 2
    change_column :transactions, :value, :decimal, precision: 8, scale: 2
  end

  def down
    change_column :transactions, :balance, :integer
    change_column :transactions, :value, :integer
  end
end
