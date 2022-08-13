class Mycat < ApplicationRecord
  has_many :eventcats
  translates :name
  def allmyeventcats
    if self.name == "Venue"
      Venue.all.joins("left join venueshavevenues e on e.venue_id = venues.id").select('venues.*, count(e.id) as countroom').group('venues.id').having('countroom = 0')
    else
    eventcats.joins("left join venuehavehalls e on e.eventcat_id = eventcats.id").select('eventcats.*, count(e.id) as countroom').group('eventcats.id').having('countroom = 0')
    end
      end
end
