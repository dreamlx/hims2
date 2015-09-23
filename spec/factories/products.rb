FactoryGirl.define do
  factory :product do
    association :fund
    name "MyString"
    desc "MyString"
    title1 "MyString"
    content1 "MyString"
    title2 "MyString"
    content2 "MyString"
    title3 "MyString"
    content3 "MyString"
    progress_bar 1
    abbr "MyString"
    currency "MyString"
    amount "MyString"
    period "MyString"
    paid "MyString"
    sales_period "MyString"
    block_period "MyString"
    redeem "MyString"
    entity "MyString"
    adviser "MyString"
    trustee "MyString"
    reg_organ "MyString"
    website "www.example.com"
    agency "MyString"
    regulatory_filing "MyString"
    legal_consultant "MyString"
    audit "MyString"
    starting_point "MyString"
    account "MyString"
    progress "MyString"
    direction "MyString"
    risk_control "MyString"
    instruction File.open(File.join(Rails.root, 'spec/fixtures/rails.png'))
    agreement "MyString"
  end
end