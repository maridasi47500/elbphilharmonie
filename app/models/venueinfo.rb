class Venueinfo < ApplicationRecord
  translates :description
  belongs_to :venue
  validates_uniqueness_of :venue_id, scope: [:mytype]
end

