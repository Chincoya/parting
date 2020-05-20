# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :param_present?, only: [:create]
  def index
    @cached_icons = {}
    @tasks = if params[:internal].present?
               Task.internal.where('author_id = ?', current_user.id).order(created_at: :desc)
             elsif params[:query].present?
               Task.where(author_id: current_user.id).where('name ILIKE :query', query: "%#{params[:query]}%")
                 .order(created_at: :desc)
             else
               Task.external.where('author_id = ?', current_user.id).order(created_at: :desc)
             end
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
    params.require(:task).permit(:name, :hours, :minutes, :group, :groups)
  end

  def process_params(params)
    valid_goups = current_user.groups.where('name IN (?)', JSON.parse(params[:groups]).keys)
    10.times do |i|
      puts '***'
    end
    puts valid_goups
    10.times do |i|
      puts '***'
    end
    group = (Group.find_by(name: params[:group]).id if params[:group].present? && params[:group] != 'None')

    { name: params[:name].strip,
      amount: ((params[:hours].to_i * 60) + params[:minutes].to_i),
      group_id: group }
  end
end
