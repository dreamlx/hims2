require 'rails_helper'

RSpec.describe "individuals" do
  describe "POST create" do
    it "create a new individual" do
      adviser = create(:user)
      Individual.delete_all
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{adviser.open_id}")
      }
      valid_attributes = attributes_for(:individual).merge(
        user_id: adviser.id,
        id_front: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/rails.png')).read),
        id_back: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/rails.png')).read))
      post "/api/individuals", {individual: valid_attributes}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(201)
      json = JSON.parse(response.body)["individual"]
      individual = Individual.first
      individual.reload
      expect(json["id"]).to eq individual.id
      expect(json["name"]).to eq individual.name
      expect(json["cell"]).to eq individual.cell
      expect(json["remark_name"]).to eq individual.remark_name
      expect(json["id_type"]).to eq individual.id_type
      expect(json["id_no"]).to eq individual.id_no
      expect(json["id_front"]["id_front"]["thumb"]["url"]).to eq individual.id_front.thumb.url
      expect(json["id_back"]["id_back"]["thumb"]["url"]).to eq individual.id_back.thumb.url
      expect(json["remark"]).to eq individual.remark
    end

    it "failed to create a new individual without individual name" do
      adviser = create(:user)
      Individual.delete_all
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{adviser.open_id}")
      }
      valid_attributes = attributes_for(:individual).merge(
        name: nil,
        user_id: adviser.id,
        id_front: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/rails.png')).read),
        id_back: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/rails.png')).read))
      post "/api/individuals", {individual: valid_attributes}, valid_header
      expect(response).not_to be_success
      expect(response).to have_http_status(422)
    end

    it "failed to create a new individual without authentication" do
      Individual.delete_all
      valid_attributes = attributes_for(:individual).merge(
        id_front: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/rails.png')).read),
        id_back: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/rails.png')).read))
      post "/api/individuals", {individual: valid_attributes}
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
  end

  describe "GET index" do
    it "get all individuals" do
      adviser = create(:user)
      Individual.delete_all
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{adviser.open_id}")
      }
      individual = create(:individual, user_id: adviser.id)
      get "/api/individuals",{}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body).first
      expect(json["id"]).to eq individual.id
      expect(json["name"]).to eq individual.name
    end

    it "failed to get all individuals without authentication" do
      individual = create(:individual)
      get "/api/individuals"
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end

    it "only get current_user individuals" do
      adviser = create(:user)
      another_adviser = create(:user)
      Individual.delete_all
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{adviser.open_id}")
      }
      individual = create(:individual, user_id: adviser.id)
      another_individual = create(:individual, user_id: another_adviser.id)
      get "/api/individuals",{}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body).first
      expect(json["id"]).to eq individual.id
      expect(json["name"]).to eq individual.name
    end
  end
end