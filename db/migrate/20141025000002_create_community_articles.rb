class CreateCommunityArticles < ActiveRecord::Migration
  def change
    create_table(:community_articles) do |t|
      t.integer   :user_id,           null: false
      t.integer   :community_id,      null: false, default: 0
      t.string    :title,             null: false, default: ""
      t.text      :body
      t.string    :ip_address,        limit: 15
      t.integer   :ip_number,         limit: 8,   default: 0
      t.integer   :state,             limit: 1,   default: 1
      t.datetime  :created_at
      t.datetime  :updated_at
    end

    add_index     :community_articles, :community_id, name: "nn_community_articles_community_id", using: :btree
    add_index     :community_articles, :user_id, name: "fk_community_articles_users_id", using: :btree

  end
end