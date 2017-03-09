# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#  sort       :integer
#

require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :request do
  let(:category) { create(:category) }

  before { signin_user }

  context 'GET /admin/categories' do
    it 'html' do
      get '/admin/categories'
      expect(response).to be_success
    end
  end

  it 'GET /admin/categories/new' do
    get '/admin/categories/new'
    expect(response).to be_success
  end

  it 'GET /admin/categories/123' do
    get "/admin/categories/#{category.id}"
    expect(response).to be_success
  end

  it 'GET /admin/categories/123/edit' do
    get "/admin/categories/#{category.id}/edit"
    expect(response).to be_success
  end

  context 'POST /admin/categories' do
    it 'success' do
      expect {
        post '/admin/categories', params: { category: data_for(:creating_category) }
      }.to change { Category.count }.by(1)
      expect(response).to be_redirect
      follow_redirect!
      expect(response).to be_success
      expect(Category.last.tags.count).to be > 0
    end
    it 'fail' do
      expect {
        post '/admin/categories', params: { category: data_for(:creating_category).merge(name: '') }
      }.not_to change { Category.count }
      expect(response).not_to be_redirect
      expect(response_flash_message('error')).to be_present
    end
  end

  context 'PUT /admin/categories/123' do
    it 'success' do
      expect {
        put "/admin/categories/#{category.id}", params: { category: { name: 'Venus' } }
      }.to change { category.reload.name }.to('Venus')
      expect(response).to be_redirect
      follow_redirect!
      expect(response).to be_success
    end
    it 'fail' do
      expect {
        put "/admin/categories/#{category.id}", params: { category: { name: '' } }
      }.not_to change { category.reload.name }
      expect(response).not_to be_redirect
      expect(response_flash_message('error')).to be_present
    end
  end

  it 'DELETE /admin/categories/123' do
    category = create(:category)
    expect {
      delete "/admin/categories/#{category.id}"
    }.to change { Category.count }.by(-1)
    follow_redirect!
    expect(response).to be_success
  end

  context 'GET /admin/categories/123/revisions' do
    it 'empty' do
      get "/admin/categories/#{category.id}/revisions"
      expect(response).to be_success
    end

    it 'has revisions' do
      Admin::Category.find(category.id).update_attribute :name, 'abcdefg'
      get "/admin/categories/#{category.id}/revisions"
      expect(response).to be_success
      expect(response.body).to match('abcdefg')
    end
  end

  context 'POST /admin/categories/123/restore' do
    it 'already restored' do
      post "/admin/categories/#{category.id}/restore"
      expect(response).to be_redirect
    end
    it 'succes' do
      category.destroy
      expect {
        post "/admin/categories/#{category.id}/restore"
      }.to change { category.reload.deleted? }.to(false)
    end
  end
end
