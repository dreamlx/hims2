require 'rails_helper'

RSpec.describe InfoField, type: :model do
  it "is valid" do
    expect(create(:info_field)).to be_valid
  end
end
