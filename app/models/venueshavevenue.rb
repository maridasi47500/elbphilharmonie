class Venueshavevenue < ApplicationRecord
  belongs_to :venue
  belongs_to :othervenue, class_name: "Venue"
  validates_uniqueness_of :venue_id, scope: :othervenue_id
end
