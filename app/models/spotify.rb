class Spotify < ApplicationRecord
  has_many :spotifieshavesubscriptions
  has_many :subscriptions, through: :spotifieshavesubscriptions
end
