require 'rails_helper'

RSpec.describe Attach, type: :model do
  it "is valid" do
    expect(create(:attach)).to be_valid
  end
end
