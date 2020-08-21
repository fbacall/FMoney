class Source < ApplicationRecord
  belongs_to :category
  has_many :transactions
  has_many :rules

  accepts_nested_attributes_for :rules

  def colour
    category.colour
  end

  def total
    transactions.sum(:value)
  end

  def earliest_transaction
    transactions.order(:date).first
  end

  def latest_transaction
    transactions.order(:date).last
  end
end
