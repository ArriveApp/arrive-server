class User < ActiveRecord::Base
  devise :database_authenticatable, :token_authenticatable, :validatable

  def school_name
  	"Nightingale"
  end
end
