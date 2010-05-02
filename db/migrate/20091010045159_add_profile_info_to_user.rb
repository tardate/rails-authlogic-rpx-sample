class AddProfileInfoToUser < ActiveRecord::Migration
  def self.up
    add_column :noobs, :photo_url, :string, :length => 255
  end

  def self.down
    remove_column :noobs, :photo_url
  end
end
