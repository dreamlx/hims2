require 'rails_helper'

RSpec.describe Picture, type: :model do
  it "is valid" do
    expect(create(:picture)).to be_valid
  end
end
