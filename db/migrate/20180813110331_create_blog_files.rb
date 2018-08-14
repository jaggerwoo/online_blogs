class CreateBlogFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :blog_files do |t|
      t.integer :blog_id
      t.string :attachment_file
      t.string :category, default: 'video'
      t.string :slug
      t.timestamps
    end
  end
end
