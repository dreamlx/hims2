FactoryGirl.define do
  factory :attach do
    title "MyString"
    attach File.open(File.join(Rails.root, 'spec/fixtures/rails.png'))
    association :attachable, factory: :product
    category "MyString"
  end
end