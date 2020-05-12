class TasksController < ApplicationController
  before_action :authenticate_user!
  def index
    @tasks = Task.where('author_id = ?', current_user.id).map do |task|
      { name: task[:name], hours: task[:amount]/60, minutes: task[:amount]%60,
        creation_date: task[:created_at] }
    end
  end

  def new
    @task = Task.new
  end

  def create
    
    if current_user.tasks.create(process_params(task_params)).valid?
      flash[:sucess] = 'Task created'
      redirect_to tasks_path
    else
      flash[:error] = 'Error creating task'
      render 'new'
    end
  end

  def destroy
    current_user.tasks.delete(params[:id])
  end

  protected

  def task_params
    params.require(:task).permit(:name, :hours, :minutes)
  end

  def process_params(params)
    return {name: params[:name],
            amount: ((params[:hours].to_i * 60) + params[:minutes].to_i) }
  end
end
