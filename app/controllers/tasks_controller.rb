# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :param_present?, only: [:create]
  def index
    @user = current_user
    @tasks = if params[:internal].present?
               Task.includes(:first_group).internal.where('author_id = ?', @user.id)
                 .order(created_at: :desc).references(:groups)
             elsif params[:query].present?
               Task.where(author_id: @user.id).where('name ILIKE :query', query: "%#{params[:query]}%")
                 .references(:groups).order(created_at: :desc)
             else
               Task.external.where('author_id = ?', @user.id).order(created_at: :desc)
             end
    @cached_icons = cache_icons(@tasks)
    @total = total_hours_from_collection(@tasks)
  end

  def new
    @groups = current_user.groups.map(&:name).unshift('None')

    @task = Task.new
  end

  def create
    @user = current_user
    @task = @user.tasks.create(process_params(task_params))
    if @task.valid?
      flash[:success] = 'Task created'
      redirect_to tasks_path(internal: true)
    else
      flash[:error] = @task.errors.full_messages
      redirect_to new_task_path
    end
  end

  def destroy
    current_user.tasks.delete(params[:id])
  end

  protected

  def total_hours_from_collection(collection)
    collection.inject(0) { |sum, item| sum + item.amount }
  end

  def param_present?
    redirect_to new_task_path unless params[:task].present?
  end

  def task_params
    params.require(:task).permit(:name, :hours, :minutes, :groups)
  end

  def process_params(params)
    valid_groups = if params[:groups] != ''
                     @user.groups.where('name IN (?)', JSON.parse(params[:groups]).keys)
                   else
                     []
                   end

    group = valid_groups.first&.id

    { name: params[:name].strip,
      amount: ((params[:hours].to_i * 60) + params[:minutes].to_i), first_group_id: group, groups: valid_groups }
  end

  def cache_icons(collection)
    cache = {}
    collection.each do |task|
      cache[task.first_group_id] = task.first_group.icon_url unless task.first_group_id.nil?
    end
    cache
  end
end
