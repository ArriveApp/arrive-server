class AddIsTeacherToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_teacher, :boolean, default: true
  end
end
