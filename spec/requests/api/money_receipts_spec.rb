require 'rails_helper'

RSpec.describe "money_receipts" do
  describe "POST create" do
    it "create a new money receipt" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      individual = create(:individual, user_id: user.id)
      order = create(:order, investable: individual)
      valid_attributes = attributes_for(:money_receipt).merge(
        order_id: order.id,
        attach: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/rails.png')).read))
      post "/api/orders/#{order.id}/money_receipts", {money_receipt: valid_attributes}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(201)
      json = JSON.parse(response.body)["money_receipt"]
      money_receipt = MoneyReceipt.first
      expect(json["id"]).to eq money_receipt.id
      expect(json["order_id"]).to eq order.id
      expect(json["amount"]).to eq money_receipt.amount.to_s
      expect(json["amount"]).to eq valid_attributes[:amount].to_s
      expect(json["bank_charge"]).to eq 0.to_d.to_s #default is zero
      expect(json["date"].to_date).to eq money_receipt.date.to_date
      expect(json["date"].to_date).to eq valid_attributes[:date].to_date
      expect(json["attach"]["attach"]["url"]).not_to be_nil
      expect(json["attach"]["attach"]["url"]).to eq money_receipt.attach.url
      expect(json["state"]).to eq "未确认" # initial state is pending
    end
  end

  describe "DELETE destroy" do
    it "destroy the requested money_receipt" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      individual = create(:individual, user_id: user.id)
      order = create(:order, investable: individual)
      money_receipt = create(:money_receipt, order_id: order.id)
      delete "/api/orders/#{order.id}/money_receipts/#{money_receipt.id}",{}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "failed to destroy the requested money_receipt if no money_receipt found" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      individual = create(:individual, user_id: user.id)
      order = create(:order, investable: individual)
      money_receipt = create(:money_receipt)
      delete "/api/orders/#{order.id}/money_receipts/#{money_receipt.id}",{}, valid_header
      expect(response).not_to be_success
      expect(response).to have_http_status(422)
    end
  end
end