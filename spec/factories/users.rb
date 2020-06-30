FactoryBot.define do
  factory :user do
    email {'temp@gmail.com'}
    password {'temppp'}
    name {'temporary'}
    address {'lahore'}
  end
  factory :random_user, class: User do
    email {Faker::Internet.unique.email}
    password {Faker::Name.name}
    name {Faker::Name.name}
    address {Faker::Address.city}
  end 
end