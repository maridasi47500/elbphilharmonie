class Eventshaveblog < ApplicationRecord
  belongs_to :blog
  belongs_to :event
  validates_uniqueness_of :blog_id, scope: :event_id
end
