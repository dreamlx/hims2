require 'rails_helper'

RSpec.describe "users" do

  describe "POST create" do
    it "create a new user" do
      User.delete_all
      valid_attributes = attributes_for(:user)
      cell_code = create(:cell_code, cell: valid_attributes[:cell])
      post "/api/users", {user: valid_attributes.merge(code: cell_code.code)}
      user = User.first
      user.reload
      expect(response).to be_success
      expect(response).to have_http_status(201)
      json = JSON.parse(response.body)["user"]
      expect(json["id"]).to eq user.id
      expect(json["cell"]).to eq user.cell
      expect(json["open_id"]).to eq user.open_id
    end

    it "failed to create a new user without parameter user" do
      invalid_attributes = attributes_for(:user).merge(password: "invalid")
      post "/api/users", invalid_attributes
      expect(response).not_to be_success
      expect(response).to     have_http_status(422)
    end

    it "failed to create a new user with wrong cell code" do
      valid_attributes  = attributes_for(:user)
      cell_code         = create(:cell_code, cell: valid_attributes[:cell])
      post "/api/users", {user: valid_attributes.merge(code: "wrong_code")}
      expect(response).not_to be_success
      expect(response).to     have_http_status(422)
    end
  end

  describe "Patch update" do
    it "update name and email" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      patch "/api/users/#{user.id}", {user: {name: "new_name", email: "foobar@example.com"}}, valid_header
      expect(response).to     be_success
      expect(response).to     have_http_status(200)
      json = JSON.parse(response.body)["user"]
      user.reload
      expect(user.name).to eq "new_name"
      expect(user.email).to eq "foobar@example.com"
      expect(json["name"]).to eq "new_name"
      expect(json["email"]).to eq "foobar@example.com"
    end

    it "failed to update name and email without authentication" do
      user = create(:user)
      patch "/api/users/#{user.id}", {user: {name: "new_name", email: "foobar@example.com"}}
      expect(response).not_to     be_success
      expect(response).to     have_http_status(401)
    end

    it "failed to update name and email without parameter of user" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      patch "/api/users/#{user.id}", {name: "new_name", email: "foobar@example.com"}, valid_header
      expect(response).not_to be_success
      expect(response).to     have_http_status(422)
    end

    it "failed to update name and email with invalid id" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      patch "/api/users/invalid", {user: {name: "new_name", email: "foobar@example.com"}}, valid_header
      expect(response).not_to be_success
      expect(response).to     have_http_status(422)
    end

    it "update many attributes" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      new_attributes = {
        id_type: "个人",
        nickname: "new_nickname",
        gender: "男",
        address: "new_address",
        card_type: "身份证",
        card_no: "new_card_no",
        card_front: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/rails.png')).read),
        card_back: 'data:image/png;base64,' + Base64.strict_encode64(File.open(File.join(Rails.root, 'spec/fixtures/rails.png')).read),
        remark: "new_remark"
      }
      patch "/api/users/#{user.id}", {user: new_attributes}, valid_header
      expect(response).to     be_success
      expect(response).to     have_http_status(200)
      json = JSON.parse(response.body)["user"]
      expect(json["id"]).to eq user.id
      expect(json["id_type"]).to eq new_attributes[:id_type]
      expect(json["nickname"]).to eq new_attributes[:nickname]
      expect(json["gender"]).to eq new_attributes[:gender]
      expect(json["address"]).to eq new_attributes[:address]
      expect(json["card_type"]).to eq new_attributes[:card_type]
      expect(json["card_no"]).to eq new_attributes[:card_no]
      expect(json["card_front"]["card_front"]["thumb"]["url"]).not_to be_nil
      expect(json["card_back"]["card_back"]["thumb"]["url"]).not_to be_nil
      expect(json["remark"]).to eq new_attributes[:remark]
    end
  end

  # uncomment the below code when necessary
  describe "GET send_code" do
    it "send code: success" do
      # get "/api/users/send_code", {cell: Rails.application.secrets.private_number}
      # expect(response).to     be_success
      # expect(response).to     have_http_status(200)
    end

    it "send code: failed" do
      # get "/api/users/send_code", {cell: "invalid cell number"}
      # expect(response).not_to be_success
      # expect(response).to     have_http_status(422)
    end
  end

  describe "GET all_investors" do
    it "get all investors name" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      individual = create(:individual, user_id: user.id)
      institution = create(:institution, user_id: user.id)
      get "/api/users/all_investors",{}, valid_header
      expect(response).to     be_success
      expect(response).to     have_http_status(200)
      json = JSON.parse(response.body)
      expect(json.first["individual:#{individual.id}"]).to eq "[个人]" + individual.name
      expect(json.last["institution:#{institution.id}"]).to eq "[机构]" + institution.name
    end
  end

  describe "GET show" do
    it "get the requested user" do
      user = create(:user)
      valid_header = {
        authorization: ActionController::HttpAuthentication::Token.encode_credentials("#{user.open_id}")
      }
      get "/api/users/#{user.id}",{}, valid_header
      expect(response).to be_success
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)["user"]
      user.reload
      expect(json["id"]).to eq user.id
      expect(json["cell"]).to eq user.cell
      expect(json["open_id"]).to eq user.open_id
    end
  end
end