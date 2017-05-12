class CreateBlogsTags < ActiveRecord::Migration[5.0]
  def change
    create_table :blogs_tags do |t|
      t.integer :blog_id
      t.integer :tag_id
      t.timestamps
    end
  end
end
