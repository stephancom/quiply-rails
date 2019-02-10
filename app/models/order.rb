class Order < ApplicationRecord
  belongs_to :user, primary_key: :old_id, inverse_of: :orders, required: true
  validates :order_num, uniqueness: { scope: :user_id }
  validates :old_id, uniqueness: true
end
