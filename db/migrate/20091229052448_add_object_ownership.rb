class AddObjectOwnership < ActiveRecord::Migration
  def self.up
	add_column :articles, :noob_id, :integer
	add_column :comments, :noob_id, :integer
  end

  def self.down
	remove_column :articles, :noob_id
	remove_column :comments, :noob_id
  end
end
