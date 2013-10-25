class HomeController < ApplicationController
  before_filter :check_for_user
  before_filter :check_credentials
  before_filter :set_cache_buster

  def index
  	@test = 'Testing'
  end
end
