# frozen_string_literal: true

module GroupsHelper
  def uncache_icons(group)
    @cached_icons[group.id] = group.icon_url unless @cached_icons.include? group.id

    @cached_icons[group.id]
  end
end
