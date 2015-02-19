class CreateUploads < ActiveRecord::Migration
  def change
    create_table(:uploads) do |t|
      t.string    :attached_file_name,          null: false, default: ''
      t.string    :attached_content_type,       null: false, default: ''
      t.integer   :attached_file_size,          null: false, default: 0
      t.datetime  :created_at
      t.datetime  :updated_at
    end
  end
end