class Eventhaveteaser < ApplicationRecord
  belongs_to :teaser
  belongs_to :event
  validates_uniqueness_of :teaser_id, scope: :event_id
end
