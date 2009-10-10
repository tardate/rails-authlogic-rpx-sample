class AddProfileInfoToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :photo_url, :string, :length => 255
  end

  def self.down
    remove_column :users, :photo_url
  end
end
