# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GroupsController, type: :controller do


  describe 'GET' do
    it 'redirects if not authenticated' do
      get :index
      expect(response).to have_http_status(:redirect)
    end

    it 'gets to index of groups if authenticated' do
      sign_in create(:user)
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      sign_in create(:user)
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET new' do
    it 'redirects to login if not authenticated' do
      get :new
      expect(response).to have_http_status(:redirect)
    end

    it 'gets to new group form authenticated' do
      sign_in create(:user)
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      sign_in create(:user)
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST to /groups' do
    it 'redirects to login if not authenticated' do
      post :create
      expect(response).to have_http_status(:redirect)
    end

    it 'renders new in presence of invalid/incomplete data' do
      sign_in create(:user)
      post :create, params: { group: {} }
      expect(response).to redirect_to('/groups/new')
    end

    it 'renders index after saving valid task' do
      sign_in create(:user)
      post :create, params: { group: {
        name: 'Sample Group'
      } }
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/groups')
    end
  end
end
