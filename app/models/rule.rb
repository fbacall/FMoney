class Rule < ApplicationRecord
  belongs_to :source
  validates :field, inclusion: { in: %w(description transaction_type) }

  def match(transactions)
    puts "Applying rule: #{regex} (#{field}) for #{source&.title}"
    transactions.each do |transaction|
      if transaction.send(field)&.match?(/#{regex}/i)
        puts "source clash!: #{transaction.source&.title} (id: #{transaction.id}, #{transaction.description} (#{transaction.transaction_type}))" if !transaction.source_id.nil? && transaction.source_id != source_id
        transaction.source = source
      end
    end
  end
end
