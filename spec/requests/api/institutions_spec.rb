require 'rails_helper'

RSpec.describe "institutions" do
  describe "POST create" do
    it "create a new institution" do
      adviser = create(:user)
      Institution.delete_all
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{adviser.open_id}")
      }
      valid_attributes = attributes_for(:institution).merge(
        user_id: adviser.id,
        business_licenses: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/rails.png')).read))
      post "/api/institutions", {institution: valid_attributes}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(201)
      json = JSON.parse(response.body)["institution"]
      institution = Institution.first
      institution.reload
      expect(json["id"]).to eq institution.id
      expect(json["name"]).to eq institution.name
      expect(json["cell"]).to eq institution.cell
      expect(json["remark_name"]).to eq institution.remark_name
      expect(json["organ_reg"]).to eq institution.organ_reg
      expect(json["business_licenses"]["business_licenses"]["thumb"]["url"]).to eq institution.business_licenses.thumb.url
      expect(json["remark"]).to eq institution.remark
    end

    it "failed to create a new institution without institution name" do
      adviser = create(:user)
      Institution.delete_all
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{adviser.open_id}")
      }
      valid_attributes = attributes_for(:institution).merge(
        name: nil,
        user_id: adviser.id,
        business_licenses: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/rails.png')).read))
      post "/api/institutions", {institution: valid_attributes}, valid_header
      expect(response).not_to be_success
      expect(response).to have_http_status(422)
    end

    it "failed to create a new institution without authentication" do
      Institution.delete_all
      valid_attributes = attributes_for(:institution)
      post "/api/institutions", {institution: valid_attributes}
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
  end

  describe "GET index" do
    it "get all institutions" do
      adviser = create(:user)
      Institution.delete_all
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{adviser.open_id}")
      }
      institution = create(:institution, user_id: adviser.id)
      get "/api/institutions",{}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body).first
      expect(json["id"]).to eq institution.id
      expect(json["name"]).to eq institution.name
      expect(json["booking_count"]).to eq 0
      expect(json["holding_count"]).to eq 0
    end

    it "failed to get all institutions without authentication" do
      institution = create(:institution)
      get "/api/institutions"
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end

    it "only get current_user institutions" do
      adviser = create(:user)
      another_adviser = create(:user)
      Individual.delete_all
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{adviser.open_id}")
      }
      institution = create(:institution, user_id: adviser.id)
      another_institution = create(:institution, user_id: another_adviser.id)
      get "/api/institutions",{}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body).first
      expect(json["id"]).to eq institution.id
      expect(json["name"]).to eq institution.name
    end
  end

  describe "GET show" do
    it "get the requested institution" do
      adviser = create(:user)
      institution = create(:institution, user_id: adviser.id)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{adviser.open_id}")
      }
      get "/api/institutions/#{institution.id}", {}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["institution"]
      expect(json["id"]).to eq institution.id
      expect(json["created_at"].to_date).to eq institution.created_at.to_date
      expect(json["booking_count"]).to eq 0
      expect(json["holding_count"]).to eq 0
    end

    it "failed to get the requested institution without authentication" do
      adviser = create(:user)
      institution = create(:institution, user_id: adviser.id)
      get "/api/institutions/#{institution.id}"
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end

    it "get the requested institution" do
      adviser = create(:user)
      institution = create(:institution, user_id: adviser.id)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{adviser.open_id}")
      }
      get "/api/institutions/invalid", {}, valid_header
      expect(response).not_to be_success
      expect(response).to have_http_status(422)
    end
  end

  describe "PATCH update" do
    it "update institution" do
      adviser = create(:user)
      institution = create(:institution, user_id: adviser.id)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{adviser.open_id}")
      }
      old_business_licenses = institution.business_licenses.thumb.url
      new_attributes = {
        name: "new_name",
        cell: "new_cell",
        remark_name: "new_remark_name",
        organ_reg: "new_organ_reg",
        business_licenses: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/another_rails.png')).read),
        remark: "new_remark"
      }
      patch "/api/institutions/#{institution.id}",{institution: new_attributes}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["institution"]
      expect(json["id"]).to eq institution.id
      expect(json["name"]).to eq new_attributes[:name]
      expect(json["cell"]).to eq new_attributes[:cell]
      expect(json["remark_name"]).to eq new_attributes[:remark_name]
      expect(json["organ_reg"]).to eq new_attributes[:organ_reg]
      expect(json["business_licenses"]["business_licenses"]["thumb"]["url"]).not_to be_nil
      expect(json["business_licenses"]["business_licenses"]["thumb"]["url"]).not_to eq old_business_licenses
      expect(json["remark"]).to eq new_attributes[:remark]
    end

    it "failed to update institution without authentication" do
      adviser = create(:user)
      institution = create(:institution, user_id: adviser.id)
      old_business_licenses = institution.business_licenses.thumb.url
      new_attributes = {
        name: "new_name",
        cell: "new_cell",
        remark_name: "new_remark_name",
        organ_reg: "new_organ_reg",
        business_licenses: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/another_rails.png')).read),
        remark: "new_remark"
      }
      patch "/api/institutions/#{institution.id}",{institution: new_attributes}
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end

    it "failed to update institution without parameter institution" do
      adviser = create(:user)
      institution = create(:institution, user_id: adviser.id)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{adviser.open_id}")
      }
      old_business_licenses = institution.business_licenses.thumb.url
      new_attributes = {
        name: "new_name",
        cell: "new_cell",
        remark_name: "new_remark_name",
        organ_reg: "new_organ_reg",
        business_licenses: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/another_rails.png')).read),
        remark: "new_remark"
      }
      patch "/api/institutions/#{institution.id}",new_attributes, valid_header
      expect(response).not_to be_success
      expect(response).to have_http_status(422)
    end

    it "failed to update institution without invalid id" do
      adviser = create(:user)
      institution = create(:institution, user_id: adviser.id)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{adviser.open_id}")
      }
      old_business_licenses = institution.business_licenses.thumb.url
      new_attributes = {
        name: "new_name",
        cell: "new_cell",
        remark_name: "new_remark_name",
        organ_reg: "new_organ_reg",
        business_licenses: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/another_rails.png')).read),
        remark: "new_remark"
      }
      patch "/api/institutions/invalid",{institution: new_attributes}, valid_header
      expect(response).not_to be_success
      expect(response).to have_http_status(422)
    end

    it "failed to update institution without authentication" do
      adviser = create(:user)
      institution = create(:institution, user_id: adviser.id)
      old_business_licenses = institution.business_licenses.thumb.url
      new_attributes = {
        name: "new_name",
        cell: "new_cell",
        remark_name: "new_remark_name",
        organ_reg: "new_organ_reg",
        business_licenses: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/another_rails.png')).read),
        remark: "new_remark"
      }
      patch "/api/institutions/#{institution.id}",{institution: new_attributes}
      expect(response).not_to be_success
      expect(response).to have_http_status(401)
    end
  end
end