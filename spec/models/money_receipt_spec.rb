require 'rails_helper'

RSpec.describe MoneyReceipt, type: :model do
  it "is valid" do
    expect(create(:money_receipt)).to be_valid
  end

  it "is invalid without order_id" do
    money_receipt = build(:money_receipt, order_id: nil)
    money_receipt.valid?
    expect(money_receipt).to be_invalid
    expect(money_receipt.errors[:order_id].first).to eq I18n.t("errors.messages.blank")
  end
end
