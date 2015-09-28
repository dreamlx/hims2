FactoryGirl.define do
  factory :info_field do
    association :product
    category "MyString"
    field_name "MyString"
    field_type "string"
  end
end