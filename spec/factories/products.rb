FactoryBot.define do
  factory :product do
    association :category
    name {Faker::Name.name}
    image  Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, "/app/assets/images/product-53.jpg")))
    price {Faker::Number.decimal(2)}
    description {Faker::Lorem.sentence}
    quantity {Faker::Number.between(1, 200)}
    rate_average {rand(1..5)}
  end
end
