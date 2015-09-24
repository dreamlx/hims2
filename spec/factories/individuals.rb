FactoryGirl.define do
  factory :individual do
    association :user
    name "MyString"
    cell "MyString"
    remark_name "MyString"
    id_type "身份证"
    id_no "MyString"
    id_front File.open(File.join(Rails.root, 'spec/fixtures/rails.png'))
    id_back File.open(File.join(Rails.root, 'spec/fixtures/rails.png'))
    remark "MyString"
  end
end