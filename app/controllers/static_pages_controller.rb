class StaticPagesController < ApplicationController
    before_action :authenticate_user!, only: :home 
  def home
  end

  def landing
  end

  def about
  end
end
