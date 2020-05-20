# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :param_present?, only: [:create]
  def index
    @tasks = if params[:internal].present?
               Task.internal.where('author_id = ?', current_user.id).order(created_at: :desc)
             elsif params[:query].present?
               Task.where(author_id: current_user.id).where('name ILIKE :query', query: "%#{params[:query]}%")
                 .order(created_at: :desc)
             else
               Task.external.where('author_id = ?', current_user.id).order(created_at: :desc)
             end
    @cached_icons = {}
  end

  def new
    @groups = current_user.groups.map(&:name).unshift('None')

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
    redirect_to new_task_path unless params[:task].present?
  end

  def task_params
    params.require(:task).permit(:name, :hours, :minutes, :groups)
  end

  def process_params(params)
    valid_groups = if params[:groups] != ""
                    current_user.groups.where('name IN (?)', JSON.parse(params[:groups]).keys)
                  else
                    []
                  end

    group = if valid_groups.first
              valid_groups.first.id
            else
              nil
            end

    { name: params[:name].strip,
      amount: ((params[:hours].to_i * 60) + params[:minutes].to_i), first_group_id: group, groups: valid_groups }
  end
end
