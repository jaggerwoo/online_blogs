class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :user_name
      t.integer :blog_id
      t.text :content
      t.integer :parent_id
      t.timestamps
    end
  end
end
