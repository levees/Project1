class CreateCommunityArticleComments < ActiveRecord::Migration
  def change
    create_table(:community_article_comments) do |t|
      t.integer   :user_id,                   null: false
      t.integer   :community_article_id,      null: false, default: 0
      t.text      :comment
      t.string    :ip_address,                limit: 15
      t.integer   :ip_number,                 limit: 8,   default: 0
      t.integer   :state,                     limit: 1,   default: 1
      t.datetime  :created_at
      t.datetime  :updated_at
    end

    add_index     :community_article_comments, :community_article_id, name: "nn_community_article_comments_article_id", using: :btree
    add_index     :community_article_comments, :user_id, name: "fk_community_article_comments_users_id", using: :btree

  end
end