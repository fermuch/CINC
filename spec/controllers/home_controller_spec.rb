# -*- encoding : utf-8 -*-
require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should redirect_to(admin_index_path)
    end
  end

end
