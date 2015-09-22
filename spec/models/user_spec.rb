require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid" do
    expect(create(:user)).to be_valid
  end

  it "is invalid without open_id" do
    user = build(:user, open_id: nil)
    user.valid?
    expect(user).to be_invalid
    expect(user.errors[:open_id].first).to eq I18n.t("errors.messages.blank")
  end

  it "is invalid without cell" do
    user = build(:user, cell: nil)
    user.valid?
    expect(user).to be_invalid
    expect(user.errors[:cell].first).to eq I18n.t("errors.messages.blank")
  end
end
