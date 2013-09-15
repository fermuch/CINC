CINC::Application.routes.draw do
  get "admin/index"
  get "admin/add_student"
  get "admin/students"
  post "admin/update_table"
  post "admin/add_student"
  root :to => "home#index"
  devise_for :users

  get "admin/states_stats"
end
