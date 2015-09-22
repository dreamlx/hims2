require 'rails_helper'

RSpec.describe CellCode, type: :model do
  it "is valid" do
    expect(create(:cell_code)).to be_valid
  end

  # cell
  it "is invalid without cell" do
    cell_code                                 = build(:cell_code, cell: nil)
    cell_code.valid?
    expect(cell_code).to                      be_invalid
    expect(cell_code.errors[:cell].first).to  eq I18n.t("errors.messages.blank")
  end

  it "is invalid when cell is duplicate" do
    cell_code                                     = create(:cell_code)
    dup_cell_code                                 = cell_code.dup
    dup_cell_code.valid?
    expect(dup_cell_code).to                      be_invalid
    expect(dup_cell_code.errors[:cell].first).to  eq I18n.t("errors.messages.taken")
  end

  it "is invalid if the length of cell more than 20" do
    cell_code                                 = build(:cell_code, cell: "1" * 21)
    cell_code.valid?
    expect(cell_code).to                      be_invalid
    expect(cell_code.errors[:cell].first).to  eq I18n.t("errors.messages.too_long", count: 20)
  end

  it "is invalid if the length of cell less than 11" do
    cell_code                                 = build(:cell_code, cell: "1" * 10)
    cell_code.valid?
    expect(cell_code).to                      be_invalid
    expect(cell_code.errors[:cell].first).to  eq I18n.t("errors.messages.too_short", count: 11)
  end

  # code
  it "is invalid without code" do
    cell_code                                 = build(:cell_code, code: nil)
    cell_code.valid?
    expect(cell_code).to                      be_invalid
    expect(cell_code.errors[:code].first).to  eq I18n.t("errors.messages.blank")
  end

  it "is invalid if code more than 6 digits" do
    cell_code                                 = build(:cell_code, code: "1" * 7)
    cell_code.valid?
    expect(cell_code).to                      be_invalid
    expect(cell_code.errors[:code].first).to  eq I18n.t("errors.messages.wrong_length", count: 6)
  end

  it "is invalid if code less than 6 digits" do
    cell_code                                 = build(:cell_code, code: "1" * 5)
    cell_code.valid?
    expect(cell_code).to                      be_invalid
    expect(cell_code.errors[:code].first).to  eq I18n.t("errors.messages.wrong_length", count: 6)
  end
end
