class User < ActiveRecord::Base
  devise :database_authenticatable, :token_authenticatable, :validatable

  belongs_to :school

  validates :pin, :uniqueness => true

  def full_name
    "#{firstname} #{lastname}"
  end

  def role
    is_teacher? ? 'Teacher' : 'Student'
  end

  def as_json(options = {})
    default_options = {only: [:authentication_token, :is_teacher]}
    super(default_options.merge(options))
  end
end
