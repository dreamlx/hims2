FactoryGirl.define do
  factory :user do
    open_id     {Faker::Lorem.characters}
    cell        {Faker::PhoneNumber.phone_number}
    name        {Faker::Name.name}
    email       "foobar@example.com"
    id_type     "个人"
    nickname   {Faker::Name.name}
    gender      "男"
    address     {Faker::Address.street_address}
    card_type   "身份证"
    card_no     "xxxxxxxx"
    card_front  File.open(File.join(Rails.root, 'spec/fixtures/rails.png'))
    card_back   File.open(File.join(Rails.root, 'spec/fixtures/rails.png'))
    remark      {Faker::Lorem.sentence}
    number      {Faker::Lorem.word}
  end
end