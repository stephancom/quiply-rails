FactoryBot.define do
  factory :order do
    sequence(:old_id, 3333) { |i| i }
    user
  end
end
