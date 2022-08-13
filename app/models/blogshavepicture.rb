class Blogshavepicture < ApplicationRecord
  belongs_to :blog
  belongs_to :mypic
  validates_uniqueness_of :mypic_id, scope: :blog_id
end
