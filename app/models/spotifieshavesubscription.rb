class Spotifieshavesubscription < ApplicationRecord
  belongs_to :spotify
  belongs_to :subscription
  validates_uniqueness_of :spotify_id, scope: :subscription_id
end
