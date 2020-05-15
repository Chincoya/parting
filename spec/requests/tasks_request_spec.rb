# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  fixtures :users
  describe 'GET index' do
    it 'redirects to login if not authenticated' do
      get :index
      expect(response).to have_http_status(:redirect)
    end

    it 'gets to index of tasks if authenticated' do
      sign_in users(:valid)
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      sign_in users(:valid)
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET new' do
    it 'redirects to login if not authenticated' do
      get :new
      expect(response).to have_http_status(:redirect)
    end

    it 'gets to new task form if authenticated' do
      sign_in users(:valid)
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      sign_in users(:valid)
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST to /task' do
    it 'redirects to login if not authenticated' do
      post :create
      expect(response).to have_http_status(:redirect)
    end

    it 'renders new in presence of invalid/incomplete data' do
      sign_in users(:valid)
      post :create, params: { task: {
        name: 'foo', hours: -1, minutes: -1
      } }
      expect(response).to redirect_to('/tasks/new')
    end

    it 'renders index after saving valid task' do
      sign_in users(:valid)
      post :create, params: { task: {
        name: 'Sample Task', hours: 1, minutes: 0
      } }
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to('/tasks?internal=true')
    end
  end
end
