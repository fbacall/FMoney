class StatsController < ApplicationController

  def monthly
    ts = current_user.transactions.excluding_savings.order(position: :desc)
    monthly = ts.group_by { |t| t.date.strftime('%Y-%m') }
    @stats = monthly.transform_values do |ts|
      inc = 0
      spe = 0

      ts.each do |t|
        if t.value < 0
          spe += t.value
        else
          inc += t.value
        end
      end

      { income: inc, spend: spe, net: inc + spe }
    end
  end

end
