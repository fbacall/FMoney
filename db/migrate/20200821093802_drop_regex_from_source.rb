class DropRegexFromSource < ActiveRecord::Migration[6.0]
  def change
    remove_column :sources, :regex
  end
end
