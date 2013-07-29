class Classes < ActiveRecord::Base
	validates :name,  presence: true,
                    length: {minimum: 1, allow_blank: true}
end
