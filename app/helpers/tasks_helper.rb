module TasksHelper
  def uncache_icons(task)
    unless @cached_icons.include? task.group_id
      @cached_icons[task.group_id] = task.icon_url
    end
    
    @cached_icons[task.group_id]
  end

end
