require 'rails_helper'

RSpec.describe "orders" do
  describe "POST create" do
    it "create a new order" do
      Order.delete_all
      adviser = create(:user)
      individual = create(:individual, user_id: adviser.id)
      fund = create(:fund)
      product = create(:product, fund_id: fund.id)
      info_field = create(:info_field, product_id: product.id, category: "个人投资者")
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
      infos_json = JSON.parse(response.body)["infos"].first
      expect(infos_json["id"]).to eq order.infos.first.id
      expect(infos_json["category"]).to eq order.infos.first.category
      expect(infos_json["field_name"]).to eq order.infos.first.field_name
      expect(infos_json["field_type"]).to eq order.infos.first.field_type
      expect(infos_json["string"]).to eq order.infos.first.string
      expect(infos_json["text"]).to eq order.infos.first.text
      expect(infos_json["photo"]["photo"]["url"]).to eq order.infos.first.photo.url
      expect(infos_json["state"]).to eq order.infos.first.state
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
      info = create(:info, order_id: order.id)
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

    it "show the requested order with infos" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      individual = create(:individual, user_id: user.id)
      order = create(:order, investable: individual)
      info = create(:info, order_id: order.id)
      get "/api/orders/#{order.id}",{}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["infos"].first
      expect(json["id"]).to eq info.id
      expect(json["field_name"]).to eq info.field_name
      expect(json["field_type"]).to eq info.field_type
      expect(json["string"]).to eq info.string
      expect(json["text"]).to eq info.text
      expect(json["photo"]["photo"]["url"]).to eq info.photo.url
      expect(json["state"]).to eq info.state
    end

    it "failed to show the requested order without right user" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      another_user = create(:user)
      individual = create(:individual, user_id: another_user.id)
      order = create(:order, investable: individual)
      info = create(:info, order_id: order.id)
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
      info = create(:info, order_id: order.id)
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

  describe "PATCH update_infos" do
    it "update the infos of order: string" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      individual = create(:individual, user_id: user.id)
      order = create(:order, investable: individual)
      string_info = create(:info, order_id: order.id, field_type: "string")
      text_info = create(:info, order_id: order.id, field_type: "text")
      photo_info = create(:info, order_id: order.id, field_type: "photo")
      old_photo_url = photo_info.photo.url
      new_attributes = {
        "#{string_info.id}": {"#{string_info.field_type}": "new_string"},
        "#{text_info.id}": {"#{text_info.field_type}": "new_text"},
        "#{photo_info.id}": {"#{photo_info.field_type}": 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/rails.png')).read)}
      }
      patch "/api/orders/#{order.id}/update_infos", {infos: new_attributes}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["infos"]
      string_json = json[0]
      text_json = json[1]
      photo_json = json[2]

      expect(string_json["id"]).to eq string_info.id
      expect(string_json["string"]).to eq "new_string"
      expect(string_json["state"]).to eq "已提交"

      expect(text_json["id"]).to eq text_info.id
      expect(text_json["text"]).to eq "new_text"
      expect(text_json["state"]).to eq "已提交"      

      photo_info.reload
      expect(photo_json["id"]).to eq photo_info.id
      expect(photo_json["photo"]["photo"]["url"]).not_to be_nil
      expect(photo_json["photo"]["photo"]["url"]).to eq photo_info.photo.url
      expect(photo_json["photo"]["photo"]["url"]).not_to eq old_photo_url
      expect(photo_json["state"]).to eq "已提交"
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
      info = create(:info, order_id: order.id)
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
      info = create(:info, order_id: order.id)
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
      individual = create(:individual)
      product = create(:product)
      order = create(:order, investable: individual, product_id: product.id)
      get "/api/orders/by_number",{number: individual.id_no}, valid_header
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
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      institution = create(:institution)
      product = create(:product)
      order = create(:order, investable: institution, product_id: product.id)
      get "/api/orders/by_number",{number: institution.organ_reg}, valid_header
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
      individual = create(:individual)
      institution = create(:institution, organ_reg: individual.id_no)
      product = create(:product)
      individual_order = create(:order, investable: individual, product_id: product.id)
      institution_order = create(:order, investable: institution, product_id: product.id)
      get "/api/orders/by_number",{number: individual.id_no}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json.count).to eq 2
    end
  end
end