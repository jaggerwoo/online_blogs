class Comment < ApplicationRecord
  belongs_to :blog

  scope :main_comment, -> { where(parent_id: nil)}
end
