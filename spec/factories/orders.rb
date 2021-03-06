FactoryGirl.define do
  factory :order do
    association :investable, factory: :individual
    association :product
    amount "9.99"
    due_date "2015-09-25"
    mail_address "MyString"
    other File.open(File.join(Rails.root, 'spec/fixtures/rails.png'))
    remark "MyString"
    state "已预约"
    booking_date "2015-09-25 11:42:31"
    deliver "未快递"
  end
end