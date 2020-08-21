module ApplicationHelper
  def number_to_money(number, options = {})
    options[:unit] ||= '£'
    number_to_currency(number, options)
  end
end
