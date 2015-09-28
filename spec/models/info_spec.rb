require 'rails_helper'

RSpec.describe Info, type: :model do
  it "is valid" do
    expect(create(:info)).to be_valid
  end
end
