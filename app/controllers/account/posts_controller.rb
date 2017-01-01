class Account::PostsController < ApplicationController
#限制必须要得登入使用者，才能看。
before_action :authenticate_user!
def index
  @posts = current_user.posts
end

end
