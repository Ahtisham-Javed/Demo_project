FactoryBot.define do
  factory :random_product, class: Product do
    title {Faker::Device.model_name}
    description {Faker::Lorem.paragraph }
    user_id {Faker::Number.number(digits: 2)}
    price {Faker::Number.number(digits: 4)}
  end 
end