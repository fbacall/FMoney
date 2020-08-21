class AddPriorityToRules < ActiveRecord::Migration[6.0]
  def change
    add_column :rules, :priority, :integer, default: 0
  end
end
