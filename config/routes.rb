# -*- encoding : utf-8 -*-
CINC::Application.routes.draw do
  root :to => "home#index"
  devise_for :users

  get  "admin/states_stats"
  get  "admin/index"
  get  "admin/add_student"
  get  "admin/students"
  get  "admin/student/log/:id", to: 'admin#student_log', as: 'admin_student_log'
  post "admin/update_table"
  post "admin/add_student"
  get  "admin/export_table"
  get  "admin/stats/(:type)", to: 'admin#stats', as: 'admin_stats'
end
