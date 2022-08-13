class Eventshavebroadcast < ApplicationRecord
  validates_uniqueness_of :event_id, scope: :concert_broadcast_id
  belongs_to :concert_broadcast
  belongs_to :event
  
end
