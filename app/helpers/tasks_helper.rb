# frozen_string_literal: true

module TasksHelper
  def uncache_icons(task)
    puts task[:first_group_id]
    return @cached_icons[task.first_group_id] unless task.first_group_id.nil?

    'default-group-icon'
  end
end
