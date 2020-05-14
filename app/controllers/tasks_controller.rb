# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :authenticate_user!
  def index
    @cached_icons = {}
    @tasks = if params[:internal].present?
               Task.internal.where('author_id = ?', current_user.id)
             else
               Task.external.where('author_id = ?', current_user.id)
             end
  end

  def new
    @groups = Group.all.map(&:name).unshift('None')

    @task = Task.new
  end

  def create
    if current_user.tasks.create(process_params(task_params)).valid?
      flash[:sucess] = 'Task created'
      redirect_to tasks_path(internal: true)
    else
      flash[:error] = 'Error creting task'
      redirect_to new_task_path
    end
  end

  def destroy
    current_user.tasks.delete(params[:id])
  end

  protected

  def param_present?
    redirect_to new_task_path unless params[:group].present?
  end

  def task_params
    params.require(:task).permit(:name, :hours, :minutes, :group)
  end

  def process_params(params)
    group = (Group.find_by(name: params[:group]).id if params[:group].present? && params[:group] != 'None')

    { name: params[:name].strip,
      amount: ((params[:hours].to_i * 60) + params[:minutes].to_i),
      group_id: group }
  end
end
