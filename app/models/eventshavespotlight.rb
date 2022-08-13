class Eventshavespotlight < ApplicationRecord
  belongs_to :event
  belongs_to :spotlight
  validates_uniqueness_of :event_id, scope: :spotlight_id
end
