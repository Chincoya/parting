require 'rails_helper'

RSpec.describe "static_pages/landing.html.erb", type: :view do
  context 'First opening of page' do
    
    it 'displays Login link' do
      render
      expect(rendered).to match(/Log in/)
    end

    it 'displays correct Javascript pack tag' do
      render
      expect(rendered).to match(/src=.+?landing.+\.?js/)
    end

  end
end
