class Order < ApplicationRecord
  belongs_to :user, primary_key: :old_id, inverse_of: :orders, required: true
  validates :order_num, uniqueness: { scope: :user_id }
  validates :old_id, uniqueness: true

  before_validation :set_next_order_num, if: :new_record?

private

  def set_next_order_num
    self.order_num ||= (user.orders.maximum(:order_num) || 0) + 1
  end
end
