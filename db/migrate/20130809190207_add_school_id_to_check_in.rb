class AddSchoolIdToCheckIn < ActiveRecord::Migration
  def change
    add_column :check_ins, :school_id, :integer
  end
end
