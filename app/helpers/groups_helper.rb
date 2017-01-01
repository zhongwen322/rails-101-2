module GroupsHelper
  #系统内建 Helper “simple_format”的使用
def render_group_description(group)
  simple_format(group.description)
end

end
