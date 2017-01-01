class GroupsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :create, :edit, :update, :destroy]
   before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]
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
   @posts = @group.posts.recent.paginate(:page => params[:page], :per_page => 5)
 end
#结束--


#建立修改功能
 def edit

 end
#结束--


#此处是实作new里表单送出的信息a部分
def create
  @group = Group.new(group_params)
  @group.user = current_user
if @group.save
  #User 在建立 group 后自动成为 group 的一员,只有下面这行是
  current_user.join!(@group)

  redirect_to groups_path
else
  render :new
end
end
#结束---


#建立更新功能
def update


if @group.update(group_params)
  redirect_to groups_path, notice: 'Update Success'
else
  render :edit
end

end
#结束---

#建立删除功能
def destroy


  @group.destroy
  flash[:alert] = "Group deleted"
  redirect_to groups_path
end
#结束---

#实际操作“加入群组”或“退出群组”
def join
   @group = Group.find(params[:id])

    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "加入本讨论版成功！"
    else
      flash[:warning] = "你已经是本讨论版成员了！"
    end

    redirect_to group_path(@group)
  end

  def quit
    @group = Group.find(params[:id])

    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:alert] = "已退出本讨论版！"
    else
      flash[:warning] = "你不是本讨论版成员，怎么退出 XD"
    end

    redirect_to group_path(@group)
  end

#结束---


#此处是实作new里表单送出的信息b部分
private

#加入find_group_and_check_permission来打包update,destroy还有edit的冗余代码
def find_group_and_check_permission
  @group = Group.find(params[:id])
  if current_user != @group.user
    redirect_to root_path, alert: "You have no permission."
  end
end
#结束---

  def group_params
  params.require(:group).permit(:title, :description)
  end
end
#结束---
