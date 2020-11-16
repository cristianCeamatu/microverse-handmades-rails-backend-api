FactoryBot.define do
  factory :item do
    name { Faker::Internet.name }
    description { Faker::Internet.name }
    price { 55.55 }
    usedFor { Faker::Internet.name }
  end
end
