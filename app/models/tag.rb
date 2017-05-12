class Tag < ApplicationRecord
  has_many :blogs_tags
  has_many :blogs, through: :blogs_tags
end
