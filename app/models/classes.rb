class Classes < ActiveRecord::Base
	validate :name, presence: true, length: { minimum: 1 }
end
