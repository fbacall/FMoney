require 'csv'

class Transaction < ApplicationRecord
  belongs_to :source, optional: true

  validates :description, uniqueness: { scope: [:value, :balance, :date] }

  acts_as_list

  def follows_on?
    higher_item && (higher_item.balance == pre_balance)
  end

  def pre_balance
    balance - value
  end

  def duplicate
    self.class.where(balance: balance, date: date, description: description, value: value)
  end

  def find_previous
    self.class.where(balance: pre_balance).where('date <= ?', date).first
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

  def self.from_paste(text)
    text.split(/[\r\n\t]+/).each_slice(6).map do |row|
      from_natwest_row(row)
    end
  end

  def self.bulk_insert(transactions)
    transactions = [transactions] if transactions.is_a?(Transaction)
    a = transactions.to_a
    return a if a.empty?

    a.sort_by(&:date).map do |t|
      previous = t.find_previous
      t.position = (previous.position + 1) if previous
      t.save
      t
    end
  end

  private

  def self.from_natwest_row(row)
    new(
        date: row[0]&.strip,
        transaction_type: row[1]&.strip,
        description: row[2]&.strip.sub(/\A'/, ''),
        value: (row[3]&.strip == '-' ? "-#{row[4]&.strip}" : row[3]&.strip)&.tr('£,',''),
        balance: row[5]&.strip&.tr('£,','')
    )
  end
end
