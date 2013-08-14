class Course < ActiveRecord::Base
	validates :name,  presence: true,
                    length: { minimum: 1, allow_blank: true },
                    uniqueness: true

  belongs_to :school

  def as_json(options = {})
    default_options = {only: [:id, :name]}
    super(default_options.merge(options))
  end
end
