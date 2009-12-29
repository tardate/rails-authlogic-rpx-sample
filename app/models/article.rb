class Article < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  belongs_to :user
  attr_accessible :name, :description
end
