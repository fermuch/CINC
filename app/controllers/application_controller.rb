# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  layout :layout_by_resource
  before_action :gon_vars

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def layout_by_resource
    if devise_controller?
      "login"
    else
      "application"
    end
  end

  def gon_vars
    gon.update_table          = admin_update_table_path
    gon.students_url          = admin_students_path('json')
    gon.admin_student_log_url = admin_student_log_path('replace_me')
    gon.action                = action_name
  end

end
