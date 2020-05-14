# frozen_string_literal: true

module TasksHelper
  def uncache_icons(task)
    @cached_icons[task.group_id] = task.icon_url unless @cached_icons.include? task.group_id

    @cached_icons[task.group_id]
  end
end
