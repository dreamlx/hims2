require 'rails_helper'

RSpec.describe Individual, type: :model do
  it "is valid" do
    expect(create(:individual)).to be_valid
  end

  it "is invalid without name" do
    individual = build(:individual, name: nil)
    individual.valid?
    expect(individual).to be_invalid
    expect(individual.errors[:name].first).to eq I18n.t("errors.messages.blank")
  end
end
