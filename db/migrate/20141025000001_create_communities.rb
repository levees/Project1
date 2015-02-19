class CreateCommunities < ActiveRecord::Migration
  def change
    create_table(:communities) do |t|
      t.string  :community_name,    limit:45, null: false, default: ""
      t.string  :community_path,    limit:45, null: false, default: ""
      t.datetime :created_at
    end
  end
end
