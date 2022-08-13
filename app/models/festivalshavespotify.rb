class Festivalshavespotify < ApplicationRecord
belongs_to :festival
belongs_to :spotify
validates_uniqueness_of :festival_id, scope: :spotify_id
end
