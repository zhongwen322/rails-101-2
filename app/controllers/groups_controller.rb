class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

#建立新建功能
def new
  @group = Group.new
end
#结束--

#此处是实作浏览功能，点群组标题链接如 Board 1 能打开该群组
def show
  @group = Group.find(params[:id])
end
#结束--

#建立修改功能
 def edit
  @group = Group.find(params[:id])
 end
#结束--


#此处是实作new里表单送出的信息a部分
def create
  @group = Group.new(group_params)
  @group.save
  redirect_to groups_path
end
#结束---


#建立更新功能
def update
  @group = Group.find(params[:id])
  @group.update(group_params)
  redirect_to groups_path,notice:"Update Success"
end
#结束---


#此处是实作new里表单送出的信息b部分
private
def group_params
  params.require(:group).permit(:title, :description)
end
#结束---


end
