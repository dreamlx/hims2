require 'rails_helper'

RSpec.describe Institution, type: :model do
  it "is valid" do
    expect(create(:institution)).to be_valid
  end

  it "is invalid without name" do
    institution = build(:institution, name: nil)
    institution.valid?
    expect(institution).to be_invalid
    expect(institution.errors[:name].first).to eq I18n.t("errors.messages.blank")
  end

  it "is invalid without cell" do
    institution = build(:institution, cell: nil)
    institution.valid?
    expect(institution).to be_invalid
    expect(institution.errors[:cell].first).to eq I18n.t("errors.messages.blank")
  end
end
