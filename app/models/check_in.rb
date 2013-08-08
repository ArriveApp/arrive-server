class CheckIn < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  def self.search_by(from, to)
    from_time = Time.strptime(from, '%m-%d-%Y').utc.beginning_of_day
    to_time = Time.strptime(to,'%m-%d-%Y').utc.end_of_day
    self.where('created_at >= ? AND created_at <= ?', from_time, to_time)
  end
end

