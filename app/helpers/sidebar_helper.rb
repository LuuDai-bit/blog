module SidebarHelper
  def active_collapse?(collapsed_members)
    path = request.original_fullpath
    member = path.split(/[\/?]/)[2]

    collapsed_members.include?(member)
  end
end
