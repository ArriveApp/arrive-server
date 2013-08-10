class User < ActiveRecord::Base
  devise :database_authenticatable, :token_authenticatable, :validatable

  belongs_to :school

  def full_name
    "#{firstname} #{lastname}"
  end

  def role
    is_teacher? ? 'Teacher' : 'Student'
  end
end
