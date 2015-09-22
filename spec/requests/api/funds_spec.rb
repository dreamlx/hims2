require 'rails_helper'

RSpec.describe "funds" do
  describe "GET index" do
    it "get all funds" do
      Fund.delete_all
      fund = create(:fund)
      get "/api/funds"
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body).first
      expect(json["id"]).to eq fund.id
      expect(json["name"]).to eq fund.name
      expect(json["desc"]).to eq fund.desc
      expect(json["title1"]).to eq fund.title1
      expect(json["content1"]).to eq fund.content1
      expect(json["title2"]).to eq fund.title2
      expect(json["content2"]).to eq fund.content2
      expect(json["title3"]).to eq fund.title3
      expect(json["content3"]).to eq fund.content3
      expect(json["progress"]).to eq fund.progress
    end
  end
end