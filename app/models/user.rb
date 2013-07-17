class User < ActiveRecord::Base
  devise :database_authenticatable, :token_authenticatable, :validatable
end
