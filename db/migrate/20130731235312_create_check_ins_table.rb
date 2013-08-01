class CreateCheckInsTable < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
      t.integer :user_id
      t.integer :course_id

      t.timestamps
    end
  end
end
