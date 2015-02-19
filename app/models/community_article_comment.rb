class CommunityArticleComment < ActiveRecord::Base
  belongs_to :community_article
  belongs_to :user
  
  #validates :user_id, :body, :presence => true

end