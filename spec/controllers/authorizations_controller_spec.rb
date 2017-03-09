# == Schema Information
#
# Table name: authorizations
#
#  id         :integer          not null, primary key
#  provider   :integer
#  uid        :string
#  auth_type  :string
#  auth_id    :integer
#  auth_data  :text
#  data       :hstore
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe AuthorizationsController, type: :request do
  context '#callback' do
    let(:fb_auth) { get '/authorizations/facebook/callback', env: { 'omniauth.auth' => omniauth_mock(:facebook) } }
    let(:google_auth) { get '/authorizations/google_oauth2/callback', env: { 'omniauth.auth' => omniauth_mock(:google_oauth2) } }
    it 'success' do
      expect {
        fb_auth
      }.to change { User.count }.by(1)
      expect(response).to be_redirect
      follow_redirect!
      expect(response).to be_success
    end

    context 'user auth fb & signed in' do
      let(:user2) { create :user, email: omniauth_mock(:facebook)[:info][:email] }
      before { fb_auth }
      before { follow_redirect! }
      before { @user = User.last }

      it 'auth google' do
        expect {
          google_auth
        }.not_to change { User.count }
        expect(@user.authorizations.count).to eq 2
      end

      it 'fail case' do
        @user.update_column :email, 'test@test.com'
        expect {
          google_auth
          follow_redirect!
        }.not_to change { @user.authorizations.count + user2.authorizations.count }
        expect(response).to be_success
      end
    end

  end
end
