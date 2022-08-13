class Blogshaveblog < ApplicationRecord
  belongs_to :blog
  belongs_to :otherblog, class_name: "Blog"
  validates_uniqueness_of :blog_id, scope: :otherblog_id
end
