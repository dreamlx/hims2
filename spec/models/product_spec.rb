require 'rails_helper'

RSpec.describe Product, type: :model do
  it "is valid" do
    expect(create(:product)).to be_valid
  end

  it "is invalid without fund_id" do
    product = build(:product, fund_id: nil)
    product.valid?
    expect(product).to be_invalid
    expect(product.errors[:fund_id].first).to eq I18n.t("errors.messages.blank")
  end

  it "is invalid without name" do
    product = build(:product, name: nil)
    product.valid?
    expect(product).to be_invalid
    expect(product.errors[:name].first).to eq I18n.t("errors.messages.blank")
  end

  it "is invalid without desc" do
    product = build(:product, desc: nil)
    product.valid?
    expect(product).to be_invalid
    expect(product.errors[:desc].first).to eq I18n.t("errors.messages.blank")
  end

  it "is invalid if progress_bar more than 100" do
    product = build(:product, progress_bar: 101)
    product.valid?
    expect(product).to be_invalid
    expect(product.errors[:progress_bar].first).to eq I18n.t("errors.messages.less_than_or_equal_to", count: 100)
  end

  it "is invalid if progress_bar less than 0" do
    product = build(:product, progress_bar: -1)
    product.valid?
    expect(product).to be_invalid
    expect(product.errors[:progress_bar].first).to eq I18n.t("errors.messages.greater_than_or_equal_to", count: 0)
  end
end