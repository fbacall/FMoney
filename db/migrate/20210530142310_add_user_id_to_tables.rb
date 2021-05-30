class AddUserIdToTables < ActiveRecord::Migration[6.0]
  def change
    add_reference :categories, :user
    add_reference :sources, :user
    add_reference :transactions, :user
  end
end
