class Blogshavetag < ApplicationRecord
  belongs_to :blog
  belongs_to :tag
  validates_uniqueness_of :blog_id,scope: :tag_id
end
