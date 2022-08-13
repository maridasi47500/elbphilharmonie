class ConcertBroadcast < ApplicationRecord
  has_many :eventshavebroadcasts
  has_many :events, through: :eventshavebroadcasts
end
