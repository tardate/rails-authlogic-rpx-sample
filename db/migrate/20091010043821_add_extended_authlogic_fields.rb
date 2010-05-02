class AddExtendedAuthlogicFields < ActiveRecord::Migration
	def self.up
		# see the Authlogic documentation for more information about these magic fields
		add_column :noobs, :login_count, :integer, :default => 0, :null => false
		add_column :noobs, :last_request_at, :datetime
		add_column :noobs, :last_login_at, :datetime
		add_column :noobs, :current_login_at, :datetime
		add_column :noobs, :last_login_ip, :string
		add_column :noobs, :current_login_ip, :string
	end

	def self.down
		remove_column :noobs, :login_count
		remove_column :noobs, :last_request_at
		remove_column :noobs, :last_login_at
		remove_column :noobs, :current_login_at
		remove_column :noobs, :last_login_ip
		remove_column :noobs, :current_login_ip
	end
end
