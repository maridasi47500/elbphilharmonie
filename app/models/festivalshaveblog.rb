class Festivalshaveblog < ApplicationRecord
  belongs_to :festival
  belongs_to :blog
  validates_uniqueness_of :festival_id, scope: :blog_id
end

