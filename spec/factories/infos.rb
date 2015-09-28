FactoryGirl.define do
  factory :info do
    association :order
    category "MyString"
    field_name "MyString"
    field_type "string"
    string "MyString"
    text "MyText"
    photo File.open(File.join(Rails.root, 'spec/fixtures/rails.png'))
    state "未确认"
  end
end