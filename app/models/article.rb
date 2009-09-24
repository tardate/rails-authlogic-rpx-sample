class Article < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  attr_accessible :name, :description
end
