class User < ApplicationRecord
  has_many :orders, primary_key: :old_id, dependent: :destroy, inverse_of: :user
  validates :old_id, uniqueness: true
end
