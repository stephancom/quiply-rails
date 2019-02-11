# represents an order
class Order < ApplicationRecord
  belongs_to :user, primary_key: :old_id, inverse_of: :orders
  validates :order_num, uniqueness: { scope: :user_id }
  validates :old_id, uniqueness: true

  before_validation :set_next_order_num, if: :new_record?

  # Finds orders for a user joining on a certain date or in a date range
  #
  # @method for_user_joined_on(join_date)
  # @scope class
  # @param join_date [DateTime, Range] join date or range, including open-ended range
  # @returns [Order]
  scope :for_user_joined_on, ->(join_date) { joins(:user).where(users: { created_at: join_date }) }

  # group orders selected by an ActiveRecord scope by week.
  #
  # @param weeks_count [Integer] how many weeks to include in columns.  Default: 8
  # @return [Array] an array of hashes, each containing counts of orderers/first time orderers for that week
  def self.count_orders_by_week(weeks_count = 8)
    group_by_week(:created_at).count.first(weeks_count).map do |(week, _)|
      week_orders = where(created_at: week..(week + 1.week))
      { orderers: week_orders.count('DISTINCT user_id'),
        first_orders: week_orders.where(order_num: 1).count }
    end
  end

  private

  def set_next_order_num
    self.order_num ||= (user.orders.maximum(:order_num) || 0) + 1
  end
end
