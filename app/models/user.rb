class User < ActiveRecord::Base
  devise :database_authenticatable, :token_authenticatable, :validatable

  belongs_to :school
end
