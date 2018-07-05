class Blog < ApplicationRecord
  searchkick word_start: [:title, :content], language: "chinese", callbacks: :async

  has_many :blogs_tags
  has_many :tags, through: :blogs_tags
  has_many :blog_images
  has_many :comments

  def tags_string= one_tags
    self.tags.destroy_all
    
    one_tags.split(',').each do |tag|
      one_tag = Tag.find_by(title: tag)
      one_tag = Tag.new(title: tag) unless one_tag

      self.tags << one_tag
    end
  end

  def search_data
    {
      title: title,
      content: content
    }
  end
end
