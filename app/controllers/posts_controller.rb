class PostsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create]


  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end

#实作修改
def edit
  @group = Group.find(params[:group_id])
  @post = Post.find(params[:id])
end
#end---


#建立更新功能
def update

if @group.update(group_params)
  redirect_to groups_path, notice: 'Update Success'
else
  render :edit
end

end
#结束---


#实作删除
def destroy
  @post = Post.find(params[:id])
  @post.destroy
  flash[:alert] = "Post deleted"
  redirect_to groups_path
end
#end---


  private

  def post_params
    params.require(:post).permit(:content)
  end

end
