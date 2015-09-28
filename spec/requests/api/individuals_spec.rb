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
      expect(json["booking_count"]).to eq 0
      expect(json["holding_count"]).to eq 0
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

  
  describe "GET show" do
    it "get the requested individual" do
      adviser = create(:user)
      individual = create(:individual, user_id: adviser.id)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{adviser.open_id}")
      }
      get "/api/individuals/#{individual.id}", {}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["individual"]
      expect(json["id"]).to eq individual.id
      expect(json["created_at"].to_date).to eq individual.created_at.to_date
      expect(json["booking_count"]).to eq 0
      expect(json["holding_count"]).to eq 0
    end

    it "failed to get the requested individual without authentication" do
      adviser = create(:user)
      individual = create(:individual, user_id: adviser.id)
      get "/api/individuals/#{individual.id}"
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end

    it "get the requested individual" do
      adviser = create(:user)
      individual = create(:individual, user_id: adviser.id)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{adviser.open_id}")
      }
      get "/api/individuals/invalid", {}, valid_header
      expect(response).not_to be_success
      expect(response).to have_http_status(422)
    end
  end

  describe "PATCH update" do
    it "update individual" do
      adviser = create(:user)
      individual = create(:individual, user_id: adviser.id)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{adviser.open_id}")
      }
      old_id_front = individual.id_front.thumb.url
      old_id_back = individual.id_back.thumb.url
      new_attributes = {
        name: "new_name",
        cell: "new_cell",
        remark_name: "new_remark_name",
        id_type: "护照",
        id_no: "new_id_no",
        id_front: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/another_rails.png')).read),
        remark: "new_remark"
      }
      patch "/api/individuals/#{individual.id}",{individual: new_attributes}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["individual"]
      expect(json["id"]).to eq individual.id
      expect(json["name"]).to eq new_attributes[:name]
      expect(json["cell"]).to eq new_attributes[:cell]
      expect(json["remark_name"]).to eq new_attributes[:remark_name]
      expect(json["id_type"]).to eq new_attributes[:id_type]
      expect(json["id_no"]).to eq new_attributes[:id_no]
      expect(json["id_front"]["id_front"]["thumb"]["url"]).not_to be_nil
      expect(json["id_front"]["id_front"]["thumb"]["url"]).not_to eq old_id_front
      expect(json["id_back"]["id_back"]["thumb"]["url"]).not_to be_nil
      expect(json["id_back"]["id_back"]["thumb"]["url"]).to eq old_id_back
      expect(json["remark"]).to eq new_attributes[:remark]
    end

    it "failed to update individual without authentication" do
      adviser = create(:user)
      individual = create(:individual, user_id: adviser.id)
      old_id_front = individual.id_front.thumb.url
      old_id_back = individual.id_back.thumb.url
      new_attributes = {
        name: "new_name",
        cell: "new_cell",
        remark_name: "new_remark_name",
        id_type: "护照",
        id_no: "new_id_no",
        id_front: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/another_rails.png')).read),
        remark: "new_remark"
      }
      patch "/api/individuals/#{individual.id}",{individual: new_attributes}
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end

    it "failed to update individual without parameter individual" do
      adviser = create(:user)
      individual = create(:individual, user_id: adviser.id)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{adviser.open_id}")
      }
      old_id_front = individual.id_front.thumb.url
      old_id_back = individual.id_back.thumb.url
      new_attributes = {
        name: "new_name",
        cell: "new_cell",
        remark_name: "new_remark_name",
        id_type: "护照",
        id_no: "new_id_no",
        id_front: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/another_rails.png')).read),
        remark: "new_remark"
      }
      patch "/api/individuals/#{individual.id}",new_attributes, valid_header
      expect(response).not_to be_success
      expect(response).to have_http_status(422)
    end

    it "failed to update individual with invalid id" do
      adviser = create(:user)
      individual = create(:individual, user_id: adviser.id)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{adviser.open_id}")
      }
      old_id_front = individual.id_front.thumb.url
      old_id_back = individual.id_back.thumb.url
      new_attributes = {
        name: "new_name",
        cell: "new_cell",
        remark_name: "new_remark_name",
        id_type: "护照",
        id_no: "new_id_no",
        id_front: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/another_rails.png')).read),
        remark: "new_remark"
      }
      patch "/api/individuals/invalid",{individual: new_attributes}, valid_header
      expect(response).not_to be_success
      expect(response).to have_http_status(422)
    end

    it "failed to update individual without authentication" do
      adviser = create(:user)
      individual = create(:individual, user_id: adviser.id)
      old_id_front = individual.id_front.thumb.url
      old_id_back = individual.id_back.thumb.url
      new_attributes = {
        name: "new_name",
        cell: "new_cell",
        remark_name: "new_remark_name",
        id_type: "护照",
        id_no: "new_id_no",
        id_front: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/another_rails.png')).read),
        remark: "new_remark"
      }
      patch "/api/individuals/#{individual.id}",{individual: new_attributes}
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end

    it "failed to update individual with invalid id_type" do
      adviser = create(:user)
      individual = create(:individual, user_id: adviser.id)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{adviser.open_id}")
      }
      old_id_front = individual.id_front.thumb.url
      old_id_back = individual.id_back.thumb.url
      new_attributes = {
        name: "new_name",
        cell: "new_cell",
        remark_name: "new_remark_name",
        id_type: "invalid",
        id_no: "new_id_no",
        id_front: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/another_rails.png')).read),
        remark: "new_remark"
      }
      patch "/api/individuals/#{individual.id}",{individual: new_attributes}, valid_header
      expect(response).not_to be_success
      expect(response).to have_http_status(422)
    end
  end
end