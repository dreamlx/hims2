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
      expect(json["state"]).to eq '已预约'
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
      expect(json["state"]).to eq '已预约'
      expect(json["booking_date"].to_date).to eq order.booking_date.to_date
      expect(json["investor_name"]).to eq order.investable.name
      expect(json["product_name"]).to eq order.product.name
      expect(json["currency"]).to eq order.product.currency
      expect(json["number"]).to eq order.investable.id_no
    end

    it "show the requested order with money_receipts and pictures" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      individual = create(:individual, user_id: user.id)
      order = create(:order, investable: individual)
      money_receipt = create(:money_receipt, order_id: order.id)
      picture = create(:picture, order_id: order.id)
      get "/api/orders/#{order.id}",{}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      m_json = JSON.parse(response.body)["money_receipts"].first
      expect(m_json["id"]).to eq money_receipt.id
      expect(m_json["amount"]).to eq money_receipt.amount.to_s
      expect(m_json["bank_charge"]).to eq money_receipt.bank_charge.to_s
      expect(m_json["date"].to_date).to eq money_receipt.date.to_date
      expect(m_json["attach"]["attach"]["url"]).to eq money_receipt.attach.url
      expect(m_json["state"]).to eq money_receipt.state
      p_json = JSON.parse(response.body)["pictures"].first
      expect(p_json["id"]).to eq picture.id
      expect(p_json["title"]).to eq picture.title
      expect(p_json["pic"]["pic"]["url"]).to eq picture.pic_url
      expect(p_json["state"]).to eq picture.state
    end

    it "failed to show the requested order without right user" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      another_user = create(:user)
      individual = create(:individual, user_id: another_user.id)
      order = create(:order, investable: individual)
      get "/api/orders/#{order.id}",{}, valid_header
      expect(response).not_to be_success
      expect(response).to have_http_status(422)
    end

    it "show the requested order" do
      adviser_user = create(:user)
      investor_user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{investor_user.open_id}")
      }
      individual = create(:individual, user_id: adviser_user.id)
      order = create(:order, investable: individual)
      get "/api/orders/#{order.id}",{number: individual.id_no}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["order"]
      expect(json["id"]).to eq order.id
      expect(json["investable_id"]).to eq order.investable_id
      expect(json["investable_type"]).to eq order.investable_type
      expect(json["product_id"]).to eq order.product_id
      expect(json["user_id"]).to eq adviser_user.id
      expect(json["amount"]).to eq order.amount.to_s
      expect(json["due_date"]).to eq order.due_date.to_date.to_s
      expect(json["mail_address"]).to eq order.mail_address
      expect(json["other"]["other"]["thumb"]["url"]).to eq order.other.thumb.url
      expect(json["remark"]).to eq order.remark
      expect(json["state"]).to eq '已预约'
      expect(json["booking_date"].to_date).to eq order.booking_date.to_date
      expect(json["investor_name"]).to eq order.investable.name
      expect(json["product_name"]).to eq order.product.name
      expect(json["currency"]).to eq order.product.currency
      expect(json["number"]).to eq order.investable.id_no
    end
  end

  describe "DELETE destroy" do
    it "destroy the requested order" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      individual = create(:individual, user_id: user.id)
      order = create(:order, investable: individual)
      money_receipt = create(:money_receipt, order_id: order.id)
      delete "/api/orders/#{order.id}",{}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "failed to destroy the requested order if order not exist" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      individual = create(:individual, user_id: user.id)
      order = create(:order, investable: individual)
      money_receipt = create(:money_receipt, order_id: order.id)
      delete "/api/orders/invalid",{}, valid_header
      expect(response).not_to be_success
      expect(response).to have_http_status(422)
    end
  end

  describe "PATCH update" do
    it "update deliver status of order" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      individual = create(:individual, user_id: user.id)
      order = create(:order, investable: individual, deliver: "未快递")
      patch "/api/orders/#{order.id}",{order: {deliver: "已快递", remark: "new remark"}}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["order"]
      expect(json["deliver"]).to eq "已快递"
      expect(json["remark"]).to eq "new remark"
    end
  end

  describe "GET by_state" do
    it "get all order's by state" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      individual = create(:individual, user_id: user.id)
      booked_order = create(:order, investable: individual, state: "已预约")
      completed_order = create(:order, investable: individual, state: "已报单")
      valued_order = create(:order, investable: individual, state: "已起息")
      get "/api/orders/by_state",{}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json["booked"].first["id"]).to eq booked_order.id
      expect(json["completed"].first["id"]).to eq completed_order.id
      expect(json["valued"].first["id"]).to eq valued_order.id
      valued_order_json = json["valued"].first
      expect(valued_order_json["id"]).to eq valued_order.id
      expect(valued_order_json["amount"]).to eq valued_order.amount.to_s
      expect(valued_order_json["investor_name"]).to eq valued_order.investable.name
      expect(valued_order_json["product_id"]).to eq valued_order.product.id
      expect(valued_order_json["product_name"]).to eq valued_order.product.name
      expect(valued_order_json["product_abbr"]).to eq valued_order.product.abbr
      expect(valued_order_json["product_desc"]).to eq valued_order.product.desc
      expect(valued_order_json["currency"]).to eq valued_order.product.currency
    end
  end

  describe "GET by_product" do
    it "get all order's by state" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      individual = create(:individual, user_id: user.id)
      product = create(:product)
      order = create(:order, investable: individual, product_id: product.id)
      get "/api/orders/by_product", {}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json.first["orders"].first["id"]).to eq order.id
    end
  end

  describe "GET by_number" do
    it "get all orders by number" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      individual = create(:individual, id_no: user.card_no)
      product = create(:product)
      order = create(:order, investable: individual, product_id: product.id)
      get "/api/orders/by_number",{number: user.card_no}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body).first
      expect(json["id"]).to eq order.id
      expect(json["product_id"]).to eq product.id
      expect(json["product_name"]).to eq product.name
      expect(json["product_desc"]).to eq product.desc
      expect(json["title1"]).to eq product.title1
      expect(json["amount"]).to eq order.amount.to_s
      expect(json["state"]).to eq "已预约"
    end

    it "get all orders by number" do
      user = create(:user, number: nil)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      institution = create(:institution, organ_reg: user.card_no)
      product = create(:product)
      order = create(:order, investable: institution, product_id: product.id)
      get "/api/orders/by_number",{number: user.card_no}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body).first
      expect(json["id"]).to eq order.id
      expect(json["product_name"]).to eq product.name
      expect(json["product_desc"]).to eq product.desc
      expect(json["title1"]).to eq product.title1
      expect(json["amount"]).to eq order.amount.to_s
    end

    it "get all orders by number" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      individual = create(:individual, id_no: user.card_no)
      institution = create(:institution, organ_reg: user.card_no)
      product = create(:product)
      individual_order = create(:order, investable: individual, product_id: product.id)
      institution_order = create(:order, investable: institution, product_id: product.id)
      get "/api/orders/by_number",{number: user.card_no}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json.count).to eq 2
    end
  end
end