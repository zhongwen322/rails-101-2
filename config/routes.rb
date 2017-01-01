Rails.application.routes.draw do
  devise_for :users
  resources :groups do

  #3实际操作“加入群组”或“退出群组”
member do
  post :join
  post :quit
end
#结束---


    resources :posts
  end
  
#可以看到自己参与的所有群组
namespace :account do
  resources :groups
end
#结束---


  root 'groups#index'
end
