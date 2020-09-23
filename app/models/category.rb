class Category < ApplicationRecord
  belongs_to :parent_category, class_name: 'Category', optional: true
  has_many :child_categories, class_name: 'Category', foreign_key: :parent_category_id, inverse_of: :parent_category
  has_many :sources

  def self.roots
    where(parent_category_id: nil)
  end

  def self.tree(categories = Category.roots)
    t = {}

    categories.each do |category|
      t[category] = tree(category.child_categories)
    end

    t
  end
end
