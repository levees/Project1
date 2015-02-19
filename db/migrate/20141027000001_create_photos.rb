class CreatePhotos < ActiveRecord::Migration
  def change
    create_table(:photos) do |t|
      t.integer   :user_id,               null: false
      t.integer   :community_article_id,  null: false
      t.string    :photo_file_name,       null: false, default: ''
      t.string    :photo_content_type,    null: false, default: ''
      t.integer   :photo_file_size,       null: false, default: 0
      t.datetime  :created_at
      t.datetime  :updated_at
    end

    add_index     :photos, :user_id, name: "fk_photos_user_id", using: :btree
    add_index     :photos, :community_article_id, name: "fk_photos_community_article_id", using: :btree

  end
end