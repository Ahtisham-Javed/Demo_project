FactoryBot.define do
  factory :random_cart, class: Cart do
    user_id {Faker::Number.number(digits: 3)}
  end
end