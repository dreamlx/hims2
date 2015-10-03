FactoryGirl.define do
  factory :user do
    open_id {Faker::Lorem.characters}
    cell    {Faker::PhoneNumber.phone_number}
    name    {Faker::Name.name}
    email   "foobar@example.com"
  end
end