class AddPinToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pin, :string, :unique => true
  end
end
