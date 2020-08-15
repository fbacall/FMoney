require 'csv'

class Transaction < ApplicationRecord
  belongs_to :source

  def pre_balance
    balance - value
  end

  def duplicate
    self.class.where(balance: balance, date: date, description: description, value: value)
  end

  def self.from_csv(io)
    t = []
    CSV.foreach(io) do |row|
      next if row[0].nil? || row[0] == 'Date'
      t << new(
          date: row[0],
          transaction_type: row[1],
          description: row[2].sub(/\A'/, ''),
          value: row[3],
          balance: row[4],
          account_name: row[5],
          account_number: row[6]
      )
    end
    t
  end
end
