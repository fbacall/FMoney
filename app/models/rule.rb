class Rule < ApplicationRecord
  belongs_to :source
  validates :field, inclusion: { in: %w(description transaction_type) }
end
