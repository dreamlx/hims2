require 'rails_helper'

RSpec.describe "pictures" do
  describe "POST create" do
    it "create a new picture" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      individual = create(:individual, user_id: user.id)
      order = create(:order, investable: individual)
      valid_attributes = attributes_for(:picture).merge(
        order_id: order.id,
        pic: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/rails.png')).read))
      post "/api/orders/#{order.id}/pictures", {picture: valid_attributes}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(201)
      json = JSON.parse(response.body)["picture"]
      picture = Picture.first
      expect(json["id"]).to eq picture.id
      expect(json["order_id"]).to eq order.id
      expect(json["title"]).to eq picture.title
      expect(json["title"]).to eq valid_attributes[:title]
      expect(json["pic"]["pic"]["url"]).not_to be_nil
      expect(json["pic"]["pic"]["url"]).to eq picture.pic.url
      expect(json["state"]).to eq "未确认" # initial state is pending
    end
  end

  describe "DELETE destroy" do
    it "destroy the requested picture" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      individual = create(:individual, user_id: user.id)
      order = create(:order, investable: individual)
      picture = create(:picture, order_id: order.id)
      delete "/api/orders/#{order.id}/pictures/#{picture.id}",{}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "failed to destroy the requested picture if no picture found" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      individual = create(:individual, user_id: user.id)
      order = create(:order, investable: individual)
      picture = create(:picture)
      delete "/api/orders/#{order.id}/pictures/#{picture.id}",{}, valid_header
      expect(response).not_to be_success
      expect(response).to have_http_status(422)
    end
  end
end