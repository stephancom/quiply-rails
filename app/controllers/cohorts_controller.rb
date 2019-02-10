# generate a table of cohorts by week
class CohortsController < ApplicationController
  def show
    # formerly User.tabulate_new_by_join_weeks
    @order_weeks = 8 # TODO: get from params
    @rows = User.group_by_week(:created_at).count.map { |(week, count)|
      timespan = week..(week + 1.week)
      users = User.where(created_at: timespan)
      user_orders = Order.where(user_id: users.pluck(:old_id))
      [helpers.timespan_format(timespan), "#{count} users"] + # TODO: I18n
        helpers.cohort_orders_per_week(user_orders, users.count, @order_weeks)
    }

    @headings = %w[Cohort Users]
    max_cols = [@rows.map(&:length).max, @order_weeks + 2].min
    @headings += (0...(max_cols - 2)).map { |w| "#{w * 7}-#{(w + 1) * 7} days" }

    # pad out rows
    @rows = @rows.map { |r| (r + [nil] * max_cols).first(max_cols) }
  end
end
