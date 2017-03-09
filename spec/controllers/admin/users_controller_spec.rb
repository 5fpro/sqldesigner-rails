# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :boolean          default(FALSE)
#  avatar                 :string
#

require 'rails_helper'

RSpec.describe Admin::UsersController, type: :request do
  before { signin_user }

  context 'GET /admin/users' do
    it 'html' do
      get '/admin/users'
      expect(response).to be_success
    end
    it 'csv' do
      get '/admin/users.csv'
      expect(response).to be_success
      expect(response.body).to match(current_user.name)
    end
  end

  it 'GET /admin/users/new' do
    get '/admin/users/new'
    expect(response).to be_success
  end

  it 'GET /admin/users/123' do
    get "/admin/users/#{current_user.id}"
    expect(response).to be_success
  end

  it 'GET /admin/users/123/edit' do
    get "/admin/users/#{current_user.id}/edit"
    expect(response).to be_success
  end

  context 'POST /admin/users' do
    it 'success' do
      expect {
        post '/admin/users', params: { user: data_for(:creating_user) }
      }.to change { User.count }.by(1)
      expect(response).to be_redirect
      follow_redirect!
      expect(response).to be_success
    end
    it 'with avatar' do
      post '/admin/users', params: { user: data_for(:creating_user, avatar: file_data) }
      expect(User.last.avatar.url).to be_present
    end
    it 'fail' do
      expect {
        post '/admin/users', params: { user: data_for(:creating_user).merge(email: '') }
      }.not_to change { User.count }
      expect(response).not_to be_redirect
      expect(response_flash_message('error')).to be_present
    end
  end

  context 'PUT /admin/users/123' do
    it 'success' do
      expect {
        put "/admin/users/#{current_user.id}", params: { user: { name: 'Venus' } }
      }.to change { current_user.reload.name }.to('Venus')
      expect(response).to be_redirect
      follow_redirect!
      expect(response).to be_success
    end
    it 'fail' do
      expect {
        put "/admin/users/#{current_user.id}", params: { user: { email: '' } }
      }.not_to change { current_user.reload.name }
      expect(response).not_to be_redirect
      expect(response_flash_message('error')).to be_present
    end
  end

  it 'DELETE /admin/users/123' do
    user = create :user
    expect {
      delete "/admin/users/#{user.id}"
    }.to change { User.count }.by(-1)
    follow_redirect!
    expect(response).to be_success
  end
end
