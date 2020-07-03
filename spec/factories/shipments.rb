FactoryBot.define do
  factory :random_shipment, class: Shipment do
    cart_id {Faker::Number.number(digits: 3)}
    product_id {Faker::Number.number(digits: 3)}
    quantity {Faker::Number.number(digits: 3)}
    status {Faker::Boolean.boolean}
  end
end