module StatsHelper
  def season_for_month(date)
    month = date.split("-").last.to_i
    if month >= 9 && month < 12
      'autumn'
    elsif month == 12 || month < 3
      'winter'
    elsif month >= 3 && month < 6
      'spring'
    else
      'summer'
    end
  end
end
