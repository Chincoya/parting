# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  fixtures :users

  describe 'GET /home' do
    it 'redirects to login page if not logged in' do
      get :home
      expect(response).to have_http_status(:redirect)
    end

    it 'returns http success if logged in' do
      sign_in users(:valid)
      get :home
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /about' do
    it 'returns http success' do
      get :about
      expect(response).to have_http_status(:success)
    end
  end
end
