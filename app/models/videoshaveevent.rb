class Videoshaveevent < ApplicationRecord
  belongs_to :video
  belongs_to :event
  validates_uniqueness_of :video_id, scope: :event_id
end
