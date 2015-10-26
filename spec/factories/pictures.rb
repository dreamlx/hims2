FactoryGirl.define do
  factory :picture do
    title "MyString"
    pic File.open(File.join(Rails.root, 'spec/fixtures/rails.png'))
    state "未确认"
    association :order
  end
end
