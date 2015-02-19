class Community < ActiveRecord::Base
  has_many :community_articles
  
end