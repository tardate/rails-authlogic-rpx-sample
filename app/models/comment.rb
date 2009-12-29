class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  attr_accessible :description
end
