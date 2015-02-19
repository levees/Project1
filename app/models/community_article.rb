class CommunityArticle < ActiveRecord::Base
  belongs_to :community
  belongs_to :user
  has_many :community_article_comments
  has_many :photos

  #has_many :community_article_likes
end
