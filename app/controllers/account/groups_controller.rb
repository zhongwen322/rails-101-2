class Account::GroupsController < ApplicationController
  #限制必须要得登入使用者，才能看。
  before_action :authenticate_user!
  def index
    @groups = current_user.participated_groups
  end
end
