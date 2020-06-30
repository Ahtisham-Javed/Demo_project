FactoryBot.define do
  factory :random_comment, class: Comment do
    comment {Faker::Lorem.paragraph}
    user_id {Faker::Number.number(digits: 3)}
    product_id {Faker::Number.number(digits: 3)}
  end
end