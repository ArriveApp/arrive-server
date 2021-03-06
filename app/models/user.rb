class User < ActiveRecord::Base
  devise :database_authenticatable, :token_authenticatable, :validatable

  PIN_LENGTH = 4

  belongs_to :school

  validates :pin, uniqueness: { scope: :school_id },
                  presence: true,
                  length: {minimum: PIN_LENGTH, maximum: PIN_LENGTH, allow_blank: true}
  validates :firstname, presence: true
  validates :lastname, presence: true

  def self.pins_for_school school_id
    select(:pin).where(school_id: school_id).map(&:pin)
  end


  def full_name
    "#{firstname} #{lastname}"
  end

  def role
    is_teacher? ? 'Teacher' : 'Student'
  end

  def as_json(options = {})
    default_options = {only: [:authentication_token, :is_teacher, :firstname]}
    super(default_options.merge(options))
  end

  def can_delete(another_user)
    if is_student or (id == another_user.id)
      return false
    end

    if is_admin
      return true
    end

    return another_user.is_student

  end

  def is_student
    not is_admin and not is_teacher
  end
end
