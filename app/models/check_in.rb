class CheckIn < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  def self.search_by(from, to)
    self.where('created_at >= ? AND created_at <= ?', from, to)
  end
end

