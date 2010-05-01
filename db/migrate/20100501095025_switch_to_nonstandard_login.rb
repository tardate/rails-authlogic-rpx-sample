class SwitchToNonstandardLogin < ActiveRecord::Migration
  def self.up
      add_column :users, :nickname, :string
      add_index :users, :nickname
	  User.all.each do |u|
		u.nickname = u.username
		u.save
	  end
      remove_column :users, :username
  end

  def self.down
      remove_column :users, :nickname
      add_column :users, :username, :string
  end
end
