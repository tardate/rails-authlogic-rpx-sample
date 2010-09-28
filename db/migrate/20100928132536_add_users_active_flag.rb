class AddUsersActiveFlag < ActiveRecord::Migration
  def self.up
    add_column :users, :active, :boolean, :default => true
  end

  def self.down
    remove_column :users, :active
  end
end
