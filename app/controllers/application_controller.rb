# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base

  before_action :gon_vars

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end


  def gon_vars
    gon.update_table = admin_update_table_path
    gon.students_url = admin_students_path('json')
    gon.action       = action_name
  end

end
