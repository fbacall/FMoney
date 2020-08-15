class Category < ApplicationRecord
  belongs_to :parent_category, class_name: 'Category'
end
