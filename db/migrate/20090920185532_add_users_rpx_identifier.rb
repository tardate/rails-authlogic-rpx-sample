class AddUsersRpxIdentifier < ActiveRecord::Migration
  def self.up
      add_column :noobs, :rpx_identifier, :string
      add_index :noobs, :rpx_identifier
  end

  def self.down
      remove_column :noobs, :rpx_identifier
  end
end
