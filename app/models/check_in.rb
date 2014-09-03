 class CheckIn < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  belongs_to :school

  validates :user, presence: true
  validates :course, presence: true
  validates :school, presence: true

  def self.search_by(from, to, school_id)
    from_time = Time.strptime(from, '%m-%d-%Y').utc.beginning_of_day
    to_time = Time.strptime(to,'%m-%d-%Y').utc.end_of_day
    self.where('school_id = ? AND created_at >= ? AND created_at <= ?', school_id, from_time, to_time)
  end

  def self.search_by_course(from,to,school_id,course_id)
    from_time = Time.strptime(from, '%m-%d-%Y').utc.beginning_of_day
    to_time = Time.strptime(to,'%m-%d-%Y').utc.end_of_day
    self.where('school_id = ?  AND course_id = ?  AND created_at >= ? AND created_at <= ?', school_id, course_id, from_time, to_time)
  end
end

