class Category < ApplicationRecord
  belongs_to :parent_category, class_name: 'Category', optional: true
  has_many :child_categories, class_name: 'Category', inverse_of: :parent_category
  has_many :sources
end
