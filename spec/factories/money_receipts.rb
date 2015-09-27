FactoryGirl.define do
  factory :money_receipt do
    association :order
    amount "9.99"
    bank_charge "9.99"
    date "2015-09-27"
    attach File.open(File.join(Rails.root, 'spec/fixtures/rails.png'))
    state "未确认"
  end
end