class TasksController < ApplicationController
  before_action :authenticate_user!
  def index
    @cached_icons = {}
    if params[:internal].present?
      @tasks = Task.internal.where('author_id = ?', current_user.id)
    else
      @tasks = Task.external.where('author_id = ?', current_user.id)
    end
  end

  def new
    @groups = Group.all.map { |group| group.name }.unshift('None')
    
    @task = Task.new
  end

  def create
    
    if current_user.tasks.create(process_params(task_params)).valid?
      flash[:sucess] = 'Task created'
      redirect_to tasks_path
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
    unless params[:group].present?
      redirect_to new_task_path
    end
  end

  def task_params
    params.require(:task).permit(:name, :hours, :minutes, :group)
  end

  def process_params(params)
    return { name: params[:name].strip,
            amount: ((params[:hours].to_i * 60) + params[:minutes].to_i),
            group_id: params[:group].present? && params[:group] != 'None' ?
                      Group.find_by(name: params[:group]).id : 
                      nil }
  end
end
