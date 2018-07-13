FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    address {Faker::Address.address}
    phone {1234567892}
    email {Faker::Internet.email}
    password "123456"
    password_confirmation "123456"
  end
end
