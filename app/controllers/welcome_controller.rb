class WelcomeController < ApplicationController
  def index
    if signed_in?
      redirect_to user_root_path
    end
  end
end
