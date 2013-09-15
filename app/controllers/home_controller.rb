# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  def index
    redirect_to admin_index_path
  end
end
