require 'rails_helper'

RSpec.describe Admin::UsersController do
  before{ signin_user }

  it "GET /admin/users" do
    get "/admin/users"
    expect(response).to be_success
  end

  it "GET /admin/users/new" do
    get "/admin/users/new"
    expect(response).to be_success
  end

  it "GET /admin/users/123" do
    get "/admin/users/#{current_user.id}"
    expect(response).to be_success
  end

  it "GET /admin/users/123/edit" do
    get "/admin/users/#{current_user.id}/edit"
    expect(response).to be_success
  end

  context "POST /admin/users" do
    it "success" do
      expect{
        post "/admin/users", user: data_for(:creating_user)
      }.to change{ User.count }.by(1)
      expect(response).to be_redirect
      follow_redirect!
      expect(response).to be_success
    end
    it "fail" do
      expect{
        post "/admin/users", user: data_for(:creating_user).merge(email: "")
      }.not_to change{ User.count }
      expect(response).not_to be_redirect
      expect(response_flash_message("error")).to be_present
    end
  end

  context "PUT /admin/users/123" do
    it "success" do
      expect{
        put "/admin/users/#{current_user.id}", user: { name: "Venus" }
      }.to change{ current_user.reload.name }.to("Venus")
      expect(response).to be_redirect
      follow_redirect!
      expect(response).to be_success
    end
    it "fail" do
      expect{
        put "/admin/users/#{current_user.id}", user: { email: "" }
      }.not_to change{ current_user.reload.name }
      expect(response).not_to be_redirect
      expect(response_flash_message("error")).to be_present
    end
  end

  it "DELETE /admin/users/123" do
    user = FactoryGirl.create :user
    expect{
      delete "/admin/users/#{user.id}"
    }.to change{ User.count }.by(-1)
    follow_redirect!
    expect(response).to be_success
  end
end
