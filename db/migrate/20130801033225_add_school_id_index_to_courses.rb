class AddSchoolIdIndexToCourses < ActiveRecord::Migration
  def change
    add_index :courses, :school_id
  end
end
