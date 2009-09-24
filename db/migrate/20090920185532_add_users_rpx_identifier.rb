class AddUsersRpxIdentifier < ActiveRecord::Migration
  def self.up
      add_column :users, :rpx_identifier, :string
      add_index :users, :rpx_identifier
  end

  def self.down
      remove_column :users, :rpx_identifier
  end
end
