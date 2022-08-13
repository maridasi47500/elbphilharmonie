class Supportingprogramme < ApplicationRecord
  belongs_to :event 
  belongs_to :otherevent, class_name: "Event"
  validates_uniqueness_of :event_id, scope: :otherevent_id
end
