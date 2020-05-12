class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    if current_user.groups.create(group_params).valid?
      flash[:sucess] = 'Group created'
      redirect_to groups_path
    else
      flash[:error] = 'Error creating group'
      render 'new'
    end
  end

  def destroy
    current_user.gropus.delete(params[:id])
  end

  protected

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
