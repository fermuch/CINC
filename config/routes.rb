CINC::Application.routes.draw do
  get "admin/index"
  post "admin/update_table"
  post "admin/add_student"
  root :to => "home#index"
  devise_for :users
end
