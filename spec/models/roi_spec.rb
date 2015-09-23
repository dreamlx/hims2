require 'rails_helper'

RSpec.describe Roi, type: :model do
  it "is valid" do
    expect(create(:roi)).to be_valid
  end

  it "is invalid without product_id" do
    roi = build(:roi, product_id: nil)
    roi.valid?
    expect(roi).to be_invalid
    expect(roi.errors[:product_id].first).to eq I18n.t("errors.messages.blank")
  end

  it "is invalid without range" do
    roi = build(:roi, range: nil)
    roi.valid?
    expect(roi).to be_invalid
    expect(roi.errors[:range].first).to eq I18n.t("errors.messages.blank")
  end

  it "is invalid without profit" do
    roi = build(:roi, profit: nil)
    roi.valid?
    expect(roi).to be_invalid
    expect(roi.errors[:profit].first).to eq I18n.t("errors.messages.blank")
  end
end
