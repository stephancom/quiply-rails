FactoryBot.define do
  factory :order do
    sequence(:old_id, 3333) { |i| i }
    order_num { 1 }
    user
  end
end
