class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

def new
  @group = Group.new
end

#此处是实做new里表单送出的信息
def create
  @group = Group.new(group_params)
  @group.save
  redirect_to groups_path
end
private
def group_params
  params.require(:group).permit(:title, :description)
end
#此处是实做new里表单送出的信息---


end
