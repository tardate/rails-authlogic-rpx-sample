class AddExtendedAuthlogicFields < ActiveRecord::Migration
	def self.up
		# see the Authlogic documentation for more information about these magic fields
		add_column :users, :login_count, :integer, :default => 0, :null => false
		add_column :users, :last_request_at, :datetime
		add_column :users, :last_login_at, :datetime
		add_column :users, :current_login_at, :datetime
		add_column :users, :last_login_ip, :string
		add_column :users, :current_login_ip, :string
	end

	def self.down
		remove_column :users, :login_count
		remove_column :users, :last_request_at
		remove_column :users, :last_login_at
		remove_column :users, :current_login_at
		remove_column :users, :last_login_ip
		remove_column :users, :current_login_ip
	end
end
