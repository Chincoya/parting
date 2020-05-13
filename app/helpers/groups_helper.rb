module GroupsHelper
  def uncache_icons(group)
    unless @cached_icons.include? group.id
      @cached_icons[group.id] = group.icon_url
    end
    
    @cached_icons[group.id]
  end
end
