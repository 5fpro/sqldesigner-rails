require 'rails_helper'

describe UserAuthContext, type: :context do
  let(:user) { create(:unconfirmed_user) }
  let(:omniauth_data) { omniauth_mock(:facebook) }
  let!(:email) { omniauth_data['info']['email'] }

  subject { described_class.new(omniauth_data, user).perform }

  context 'with current_user' do
    it 'first bind' do
      expect {
        @result = subject
      }.to change { user.reload.authorizations.count }.from(0).to(1)
      expect(user.authorizations.last.auth_data).to be_present
      expect(@result[:user].id).to eq user.id
    end
    it 'unconfirm to confirm' do
      if user.confirmable?
        expect {
          subject
        }.to change { user.reload.confirmed? }.to(true)
      end
    end
    it 'user2 has the same email' do
      create(:user, email: email)
      expect {
        @result = subject
      }.not_to change { user.reload.authorizations.count }
      expect(@result).to eq false
    end
    it 'user2 has the same email with google auth' do
      expect {
        described_class.new(omniauth_mock(:google_oauth2)).perform
      }.to change { User.count }.by(1)
      expect {
        subject
      }.not_to change { user.reload.authorizations.count }
    end
    it 'facebook then google with the same user' do
      expect {
        subject
      }.to change { user.reload.authorizations.count }.from(0).to(1)
      expect {
        described_class.new(omniauth_mock(:google_oauth2), user).perform
      }.to change { user.reload.authorizations.count }.from(1).to(2)
    end
    context 'already bind' do
      before { subject }

      it 'bind the same' do
        expect {
          subject
        }.not_to change { user.reload.authorizations.count }
      end
    end
    context 'already bind to user2' do
      let!(:user2) { create(:user, email: email) }
      before { described_class.new(omniauth_data, user2).perform }

      it 'authorizations count' do
        expect {
          subject
        }.not_to change { user.reload.authorizations.count }
      end
      it 'update auth_data' do
        authorization = user2.authorizations.last
        authorization.update_attribute :auth_data, nil
        expect {
          subject
        }.not_to change { authorization.reload.auth_data }
      end
    end
  end

  context 'no current_user' do
    it 'success' do
      expect {
        described_class.new(omniauth_data).perform
      }.to change { User.count }.by(1)
      expect(User.last.authorizations.count).to eq 1
    end
    it 'email exists will auto find and bind' do
      user.update_column :email, email
      expect {
        described_class.new(omniauth_data).perform
      }.to change { user.reload.authorizations.count }.by(1)
    end
    it 'new user bind to google' do
      user = described_class.new(omniauth_data).perform[:user]
      expect {
        described_class.new(omniauth_mock(:google_oauth2), user).perform
      }.to change { user.authorizations.count }.by(1)
    end
  end

  context 'no email' do
    it { expect { described_class.new(omniauth_data.merge(info: nil)).perform }.not_to change { User.count } }
  end
end
