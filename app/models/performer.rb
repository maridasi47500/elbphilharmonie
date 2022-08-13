class Performer < ApplicationRecord
  belongs_to :musician
  belongs_to :event
  validates_uniqueness_of :musician_id, scope: :event_id
end
