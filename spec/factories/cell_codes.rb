FactoryGirl.define do
  factory :cell_code do
    cell {Faker::Number.number(11).to_s}
    code "6" * 6
  end
end