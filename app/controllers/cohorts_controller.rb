# generate a table of cohorts by week
class CohortsController < ApplicationController
  def show
    max_weeks = 8 # TODO: get from params
    @rows = User.group_by_week(:created_at).count.map { |(week, count)|
      timespan = week..(week + 1.week)
      { timespan: timespan, count: count,
        weeks: Order.for_user_joined_on(timespan).count_orders_by_week(max_weeks) }
    }

    @week_cols = [@rows.map { |r| r[:weeks].length }.max, max_weeks].min

    # pad out rows
    @rows.reverse!.each do |row|
      row[:weeks].fill(nil, row[:weeks].length...@week_cols)
    end
  end
end
