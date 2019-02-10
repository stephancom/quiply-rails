class User < ApplicationRecord
  has_many :orders, primary_key: :old_id, dependent: :destroy, inverse_of: :user
  validates :old_id, uniqueness: true

  def self.tabulate_new_by_join_week(order_weeks = 8)
    group_by_week(:created_at).count.map do |(week, count)|
      timespan = week..(week + 1.week)
      users = where(created_at: timespan)
      user_orders = Order.where(user_id: users.pluck(:old_id))
      [Quiply.timespan_format(timespan), "#{count} users"] + # TODO: I18n
        user_orders.tabulate_by_user_week(users.count, order_weeks)
    end
  end
end
