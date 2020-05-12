class StaticPagesController < ApplicationController
    before_action :authenticate_user!, only: :home 
  def home
  end

  def landing
    redirect_to tasks_path if current_user
  end

  def about
  end
end
