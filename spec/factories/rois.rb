FactoryGirl.define do
  factory :roi do
    association :product
    range "MyString"
    profit "MyString"
  end
end