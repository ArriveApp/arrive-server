class Report

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  Type = Struct.new :id, :value, :student_populator

  StudentsWithCheckins    = Proc.new do |report|
    CheckIn.search_by_course(report.from, report.to, report.school_id, report.course_id)
  end

  StudentsWithoutCheckins = Proc.new do |report|
    students_with_check_in = CheckIn.search_by_course(report.from, report.to, report.school_id, report.course_id).select(:user_id).distinct
    User.where(is_teacher: false, is_admin:false, school_id: report.school_id).where.not(id: students_with_check_in)
  end

  TYPES= [
    Type.new('students_with_checkins', "Students with checkins", StudentsWithCheckins),
    Type.new('students_without_checkins', "Students without checkins", StudentsWithoutCheckins),
  ]

  attr_accessor :school_id, :course_id, :from, :to, :type, :results

  validate do |report|
    report.errors.add(:base, "Report has to be selected") if type.blank?
    report.errors.add(:base, "Course has to be selected") if course_id.blank?
  end

  def initialize school_id
    @school_id = school_id
    @from = Time.now.utc.strftime('%m-%d-%Y')
    @to = Time.now.utc.strftime('%m-%d-%Y')
  end

  def self.build report_attrs, school_id
    Report.new(school_id).tap do |r|
      r.course_id = report_attrs['course_id'].to_i if !report_attrs['course_id'].blank?
      r.type = report_attrs['type']
      r.from = report_attrs['from']
      r.to = report_attrs['to']
    end
  end

  def populate_results
    type = TYPES.find { |report_type| report_type.id == @type }
    @results = type.student_populator.call(self)
  end

  def persisted?
    false
  end

end
