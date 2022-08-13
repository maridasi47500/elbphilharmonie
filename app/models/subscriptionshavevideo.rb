class Subscriptionshavevideo < ApplicationRecord
  belongs_to :subscription
  belongs_to :video
  validates_uniqueness_of :subscription_id, scope: :video_id
end
