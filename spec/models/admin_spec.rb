require 'rails_helper'

RSpec.describe Admin, type: :model do
  it "is valid" do
    expect(create(:admin)).to be_valid
  end

  it "is invalid if length of password less than 6" do
    admin = build(:admin, password: "fooba", password_confirmation: "fooba")
    admin.valid?
    expect(admin).to be_invalid
    expect(admin.errors[:password].first).to eq I18n.t("errors.messages.too_short", count: 6)
  end
end
