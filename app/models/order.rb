class Order < ApplicationRecord
  belongs_to :user, primary_key: :old_id, inverse_of: :orders
  validates :order_num, uniqueness: { scope: :user_id }
  validates :old_id, uniqueness: true

  before_validation :set_next_order_num, if: :new_record?

  def self.count_orders_by_week(weeks_count = 8)
    group_by_week(:created_at).count.first(weeks_count).map do |(week, _)|
      week_orders = where(created_at: week..(week + 1.week))
      first_orders = week_orders.where(order_num: 1)
      { orderers: week_orders.pluck(:user_id).uniq.count,
        first_orders: first_orders.count }
    end
  end

  private

  def set_next_order_num
    self.order_num ||= (user.orders.maximum(:order_num) || 0) + 1
  end
end