FactoryBot.define do
  factory :user do
    sequence(:old_id, 1111) { |i| i }
  end
end
