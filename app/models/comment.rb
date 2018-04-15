class Comment < ApplicationRecord
  belongs_to :blog, touch: true

  scope :main_comment, -> { where(parent_id: nil)}
end
