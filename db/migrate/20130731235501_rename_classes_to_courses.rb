class RenameClassesToCourses < ActiveRecord::Migration
  def change
    rename_table :classes, :courses
  end
end
