require 'rails_helper'

RSpec.describe Fund, type: :model do
  it "is valid" do
    expect(create(:fund)).to be_valid
  end

  it "is invalid without name" do
    fund = build(:fund, name: nil)
    fund.valid?
    expect(fund).to be_invalid
    expect(fund.errors[:name].first).to eq I18n.t("errors.messages.blank")
  end

  it "is invalid without desc" do
    fund = build(:fund, desc: nil)
    fund.valid?
    expect(fund).to be_invalid
    expect(fund.errors[:desc].first).to eq I18n.t("errors.messages.blank")
  end

  it "is invalid if progress more than 100" do
    fund = build(:fund, progress: 101)
    fund.valid?
    expect(fund).to be_invalid
    expect(fund.errors[:progress].first).to eq I18n.t("errors.messages.less_than_or_equal_to", count: 100)
  end

  it "is invalid if progress less than 0" do
    fund = build(:fund, progress: -1)
    fund.valid?
    expect(fund).to be_invalid
    expect(fund.errors[:progress].first).to eq I18n.t("errors.messages.greater_than_or_equal_to", count: 0)
  end
end
