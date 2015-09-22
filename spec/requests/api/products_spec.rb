require 'rails_helper'

RSpec.describe "products" do
  describe "GET index" do
    it "get all products" do
      Product.delete_all
      fund = create(:fund)
      product = create(:product, fund_id: fund.id)
      get "/api/funds/#{fund.id}/products"
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body).first
      expect(json["id"]).to eq product.id
      expect(json["name"]).to eq product.name
      expect(json["desc"]).to eq product.desc
      expect(json["title1"]).to eq product.title1
      expect(json["content1"]).to eq product.content1
      expect(json["title2"]).to eq product.title2
      expect(json["content2"]).to eq product.content2
      expect(json["title3"]).to eq product.title3
      expect(json["content3"]).to eq product.content3
      expect(json["progress_bar"]).to eq product.progress_bar
    end
  end

  describe "GET show" do
    it "get the requested product" do
      product = create(:product)
      get "/api/products/#{product.id}"
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["product"]
      expect(json["id"]).to eq product.id
      expect(json["name"]).to eq product.name
      expect(json["abbr"]).to eq product.abbr
      expect(json["currency"]).to eq product.currency
      expect(json["amount"]).to eq product.amount
      expect(json["period"]).to eq product.period
      expect(json["paid"]).to eq product.paid
      expect(json["sales_period"]).to eq product.sales_period
      expect(json["block_period"]).to eq product.block_period
      expect(json["redeem"]).to eq product.redeem
      expect(json["entity"]).to eq product.entity
      expect(json["adviser"]).to eq product.adviser
      expect(json["trustee"]).to eq product.trustee
      expect(json["reg_organ"]).to eq product.reg_organ
      expect(json["website"]).to eq product.website
      expect(json["agency"]).to eq product.agency
      expect(json["regulatory_filing"]).to eq product.regulatory_filing
      expect(json["legal_consultant"]).to eq product.legal_consultant
      expect(json["audit"]).to eq product.audit
      expect(json["starting_point"]).to eq product.starting_point
      expect(json["account"]).to eq product.account
      expect(json["progress"]).to eq product.progress
      expect(json["direction"]).to eq product.direction
      expect(json["risk_control"]).to eq product.risk_control
      expect(json["instruction"]).to eq product.instruction
      expect(json["agreement"]).to eq product.agreement
    end

    # when the filed is nil, it will not show up
    it "get the requested product" do
      product = create(:product, agency: nil)
      get "/api/products/#{product.id}"
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["product"]
      expect(json["id"]).to eq product.id
      expect(json["agency"]).to be_nil
    end
  end
end