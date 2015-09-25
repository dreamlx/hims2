require 'rails_helper'

RSpec.describe Order, type: :model do
  it "is valid" do
    expect(create(:order)).to be_valid
  end

  it "is invalid without product_id" do
    order = build(:order ,product_id: nil)
    order.valid?
    expect(order).to be_invalid
    expect(order.errors[:product_id].first).to eq I18n.t("errors.messages.blank")
  end

  it "is invalid without investable_id" do
    order = build(:order ,investable_id: nil)
    order.valid?
    expect(order).to be_invalid
    expect(order.errors[:investable].first).to eq I18n.t("errors.messages.blank")
  end

  it "is invalid without investable_type" do
    order = build(:order ,investable_type: nil)
    order.valid?
    expect(order).to be_invalid
    expect(order.errors[:investable].first).to eq I18n.t("errors.messages.blank")
  end

  it "is invalid without amount" do
    order = build(:order ,amount: nil)
    order.valid?
    expect(order).to be_invalid
    expect(order.errors[:amount].first).to eq I18n.t("errors.messages.not_a_number")
  end

  it "is invalid without amount" do
    order = build(:order ,amount: 0)
    order.valid?
    expect(order).to be_invalid
    expect(order.errors[:amount].first).to eq I18n.t("errors.messages.greater_than_or_equal_to", count: 0.01)
  end
end
