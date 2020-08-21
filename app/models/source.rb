class Source < ApplicationRecord
  belongs_to :category
  has_many :rules

  accepts_nested_attributes_for :rules
end
