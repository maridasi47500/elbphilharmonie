class Contentshaveseries < ApplicationRecord
  belongs_to :content
  belongs_to :concert_series
  validates_uniqueness_of :content_id, scope: :concert_series_id
end
