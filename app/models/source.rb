class Source < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :transactions
  has_many :rules

  accepts_nested_attributes_for :rules, allow_destroy: true

  def colour
    category.colour
  end

  def total
    transactions.sum(:value) || 0
  end

  def earliest_transaction
    transactions.order(:date).first
  end

  def latest_transaction
    transactions.order(:date).last
  end
end
