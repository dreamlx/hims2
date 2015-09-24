FactoryGirl.define do
  factory :institution do
    association :user
    name "MyString"
    cell "MyString"
    remark_name "MyString"
    organ_reg "MyString"
    business_licenses "MyString"
    remark "MyString"
  end
end