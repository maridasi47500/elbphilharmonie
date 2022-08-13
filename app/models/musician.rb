class Musician < ApplicationRecord
  belongs_to :artist
  belongs_to :musical_instrument
  validates_uniqueness_of :artist_id, scope: :musical_instrument_id
end
