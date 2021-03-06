# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :param_present?, only: [:create]

  def index
    @cached_icons = {}
    @groups = current_user.groups.order(:name)
  end

  def show
    @cached_icons = {}
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    if current_user.groups.create(process_params(group_params)).valid?
      flash[:sucess] = 'Group created'
      redirect_to groups_path
    else
      flash[:error] = 'Error creating group'
      redirect_to new_group_path
    end
  end

  def destroy
    current_user.groups.delete(params[:id])
  end

  protected

  def param_present?
    redirect_to new_group_path unless params[:group].present?
  end

  def group_params
    params.require(:group).permit(:name, :icon)
  end

  def process_params(params)
    { name: params[:name].strip, icon: params[:icon] }
  end
end
