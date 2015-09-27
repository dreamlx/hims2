require 'rails_helper'

RSpec.describe "orders" do
  describe "POST create" do
    it "create a new order" do
      Order.delete_all
      adviser = create(:user)
      individual = create(:individual, user_id: adviser.id)
      fund = create(:fund)
      product = create(:product, fund_id: fund.id)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{adviser.open_id}")
      }
      valid_attributes = attributes_for(:order).merge(
        investable_id: "individual:#{individual.id}",
        product_id: product.id,
        other: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/rails.png')).read))
      post "/api/orders",{order: valid_attributes}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(201)
      json = JSON.parse(response.body)["order"]
      order = Order.first
      order.reload
      expect(json["id"]).to eq order.id
      expect(json["investable_id"]).to eq order.investable_id
      expect(json["investable_type"]).to eq order.investable_type
      expect(json["product_id"]).to eq order.product_id
      expect(json["user_id"]).to eq adviser.id
      expect(json["amount"]).to eq order.amount.to_s
      expect(json["due_date"]).to eq order.due_date.to_date.to_s
      expect(json["mail_address"]).to eq order.mail_address
      expect(json["other"]["other"]["thumb"]["url"]).to eq order.other.thumb.url
      expect(json["remark"]).to eq order.remark
      expect(json["state"]).to eq '已经预约，等待完成报单'
    end

    it "failed to create a new order without authentication" do
      Order.delete_all
      adviser = create(:user)
      individual = create(:individual, user_id: adviser.id)
      fund = create(:fund)
      product = create(:product, fund_id: fund.id)
      valid_attributes = attributes_for(:order).merge(
        investable_id: "individual:#{individual.id}",
        product_id: product.id,
        other: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/rails.png')).read))
      post "/api/orders",{order: valid_attributes}
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end

    it "failed to create a new order without product_id" do
      Order.delete_all
      adviser = create(:user)
      individual = create(:individual, user_id: adviser.id)
      fund = create(:fund)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{adviser.open_id}")
      }
      valid_attributes = attributes_for(:order).merge(
        investable_id: "individual:#{individual.id}",
        product_id: nil,
        other: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/rails.png')).read))
      post "/api/orders",{order: valid_attributes}, valid_header
      expect(response).not_to be_success
      expect(response).to have_http_status(422)
    end

    it "failed to create a new order without params order" do
      Order.delete_all
      adviser = create(:user)
      individual = create(:individual, user_id: adviser.id)
      fund = create(:fund)
      product = create(:product, fund_id: fund.id)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{adviser.open_id}")
      }
      valid_attributes = attributes_for(:order).merge(
        investable_id: "individual:#{individual.id}",
        product_id: product.id,
        other: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/rails.png')).read))
      post "/api/orders", valid_attributes, valid_header
      expect(response).not_to be_success
      expect(response).to have_http_status(422)
    end

    it "failed to create a new order with wrong authentication" do
      Order.delete_all
      adviser = create(:user)
      another_adviser = create(:user)
      individual = create(:individual, user_id: adviser.id)
      fund = create(:fund)
      product = create(:product, fund_id: fund.id)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{another_adviser.open_id}")
      }
      valid_attributes = attributes_for(:order).merge(
        investable_id: "individual:#{individual.id}",
        product_id: product.id,
        other: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/rails.png')).read))
      post "/api/orders", {order: valid_attributes}, valid_header
      expect(response).not_to be_success
      expect(response).to have_http_status(422)
    end
  end

  describe "GET show" do
    it "show the requested order" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      individual = create(:individual, user_id: user.id)
      order = create(:order, investable: individual)
      get "/api/orders/#{order.id}",{}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["order"]
      expect(json["id"]).to eq order.id
      expect(json["investable_id"]).to eq order.investable_id
      expect(json["investable_type"]).to eq order.investable_type
      expect(json["product_id"]).to eq order.product_id
      expect(json["user_id"]).to eq user.id
      expect(json["amount"]).to eq order.amount.to_s
      expect(json["due_date"]).to eq order.due_date.to_date.to_s
      expect(json["mail_address"]).to eq order.mail_address
      expect(json["other"]["other"]["thumb"]["url"]).to eq order.other.thumb.url
      expect(json["remark"]).to eq order.remark
      expect(json["state"]).to eq '已经预约，等待完成报单'
    end

    it "show the requested order with money_receipts" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      individual = create(:individual, user_id: user.id)
      order = create(:order, investable: individual)
      money_receipt = create(:money_receipt, order_id: order.id)
      get "/api/orders/#{order.id}",{}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["money_receipts"].first
      expect(json["id"]).to eq money_receipt.id
      expect(json["amount"]).to eq money_receipt.amount.to_s
      expect(json["bank_charge"]).to eq money_receipt.bank_charge.to_s
      expect(json["date"].to_date).to eq money_receipt.date.to_date
      expect(json["attach"]["attach"]["url"]).to eq money_receipt.attach.url
      expect(json["state"]).to eq money_receipt.state
    end
  end
end