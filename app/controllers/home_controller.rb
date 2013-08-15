class HomeController < ApplicationController
  before_filter :check_for_user
  before_filter :check_credentials

  def index
  	@test = 'Testing'
  end
end
