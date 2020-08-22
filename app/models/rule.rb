class Rule < ApplicationRecord
  MATCH_FIELDS = %w(description transaction_type).freeze
  belongs_to :source
  validates :field, inclusion: { in: MATCH_FIELDS }

  def match(transactions)
    puts "Applying rule: #{regex} (#{field}) for #{source&.title}"
    transactions.each do |transaction|
      if transaction.send(field)&.match?(/#{regex}/i)
        puts "source clash!: #{transaction.source&.title} (id: #{transaction.id}, #{transaction.description} (#{transaction.transaction_type}))" if !transaction.source_id.nil? && transaction.source_id != source_id
        transaction.source = source
      end
    end
  end

  def field= f
    super(f.to_sym)
  end
end
