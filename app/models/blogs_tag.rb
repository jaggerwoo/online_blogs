class BlogsTag < ApplicationRecord
  belongs_to :tag, touch: true
  belongs_to :blog, touch: true
end
