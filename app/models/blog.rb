class Blog < ApplicationRecord
  has_many :blogs_tags
  has_many :tags, through: :blogs_tags
  has_many :blog_images, dependent: :destroy
  has_many :comments
  has_many :blog_files, dependent: :destroy

  def tags_string= one_tags
    self.tags.destroy_all
    
    one_tags.split(',').each do |tag|
      one_tag = Tag.find_by(title: tag)
      one_tag = Tag.new(title: tag) unless one_tag

      self.tags << one_tag
    end
  end
end
