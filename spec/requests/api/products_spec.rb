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
      expect(json["fund_name"]).to eq fund.name
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
      expect(json["label"]).to eq product.label
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
      expect(json["desc"]).to eq product.desc
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
      expect(json["rate"]).to eq product.rate
      expect(json["account"]).to eq product.account
      expect(json["progress"]).to eq product.progress
      expect(json["direction"]).to eq product.direction
      expect(json["risk_control"]).to eq product.risk_control
      expect(json["instruction"]["instruction"]["url"]).to eq product.instruction.url
      expect(json["agreement"]["agreement"]["url"]).to eq product.agreement.url
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

    it "get the requested product with rois" do
      product = create(:product)
      roi = create(:roi, product_id: product.id)
      get "/api/products/#{product.id}"
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["product"]["rois"].first
      expect(json["range"]).to eq roi.range
      expect(json["profit"]).to eq roi.profit
    end
  end

  describe "GET send_mail" do
    it "send a email" do
      # product = create(:product)
      # expect(product.instruction.url).not_to be_nil
      # email = Rails.application.secrets.to_email
      # get "/api/products/#{product.id}/send_mail", {email: email}
      # expect(response).to                     be_success
      # expect(response).to                     have_http_status(200)
      # json                                    = JSON.parse(response.body)
      # expect(json["message"]).to              eq "success"
      # expect(json["email_id_list"].empty?).to eq false
    end

    it "would not send the email without email address" do
      product = create(:product)
      expect(product.instruction.url).not_to be_nil
      email = Rails.application.secrets.to_email
      get "/api/products/#{product.id}/send_mail"
      expect(response).not_to     be_success
      expect(response).to         have_http_status(422)
      json                        = JSON.parse(response.body)
      expect(json["message"]).to  eq "failed"
    end
  end

  describe "GET my" do
    it "find my products with orders" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      individual = create(:individual, user_id: user.id)
      product = create(:product)
      order = create(:order, investable: individual, product_id: product.id)
      get "/api/products/my", {}, valid_header
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
      order_json = json["orders"].first
      expect(order_json["id"]).to eq order.id
      expect(order_json["investor_name"]).to eq individual.name
      expect(order_json["amount"]).to eq order.amount.to_s
      expect(order_json["state"]).to eq "已预约"
    end
  end

  describe "GET orderd" do
    it "get the orderd product" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      individual = create(:individual, user_id: user.id)
      product = create(:product)
      order = create(:order, investable: individual, product_id: product.id)
      notice = create(:attach, attachable: product, category: "基金公告")
      report = create(:attach, attachable: product, category: "投资报告")
      get "/api/products/#{product.id}/ordered", {}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["product"]
      expect(json["id"]).to eq product.id
      expect(json["name"]).to eq product.name
      expect(json["title4"]).to eq product.title4
      expect(json["content4"]).to eq product.content4
      expect(json["title5"]).to eq product.title5
      expect(json["content5"]).to eq product.content5
      expect(json["title6"]).to eq product.title6
      expect(json["content6"]).to eq product.content6
      expect(json["title7"]).to eq product.title7
      expect(json["content7"]).to eq product.content7
      expect(json["notices"].first["id"]).to eq notice.id
      expect(json["notices"].first["title"]).to eq notice.title
      expect(json["notices"].first["attach"]["attach"]["url"]).to eq notice.attach.url
      expect(json["notices"].first["date"].to_date).to eq notice.updated_at.to_date
      expect(json["reports"].first["id"]).to eq report.id
      expect(json["reports"].first["title"]).to eq report.title
      expect(json["reports"].first["attach"]["attach"]["url"]).to eq report.attach.url
      expect(json["reports"].first["date"].to_date).to eq report.updated_at.to_date
    end
  end
end