class Festivalshavevideo < ApplicationRecord
  belongs_to :festival
  belongs_to :video
  validates_uniqueness_of :festival_id, scope: :video_id
end
