class CreateBlogImages < ActiveRecord::Migration[5.0]
  def change
    create_table :blog_images do |t|
      t.integer :blog_id
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.datetime :image_update_at
      t.timestamps
    end
  end
end
