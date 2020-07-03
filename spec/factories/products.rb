FactoryBot.define do
  factory :product do
    title {"Lenovo i7"}
    description {"A new generation laptop with all necessary features"}
    user_id {1}
    price {900}
  end
  factory :random_product, class: Product do
    title {Faker::Device.model_name}
    description {Faker::Lorem.paragraph }
    user_id {Faker::Number.number(digits: 2)}
    price {Faker::Number.number(digits: 4)}
  end 
end