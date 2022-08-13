class Eventhavepiece < ApplicationRecord
  belongs_to :event
  belongs_to :piece
  validates_uniqueness_of :piece_id, scope: :event_id
end
