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
      patch "/api/users/#{user.id}", {user: {name: "new_name", email: "foobar@example.com"}}
      expect(response).to     be_success
      expect(response).to     have_http_status(200)
      json = JSON.parse(response.body)["user"]
      user.reload
      expect(user.name).to eq "new_name"
      expect(user.email).to eq "foobar@example.com"
      expect(json["name"]).to eq "new_name"
      expect(json["email"]).to eq "foobar@example.com"
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
end