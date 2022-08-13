class Subscriptionshaveevent < ApplicationRecord
  belongs_to :subscription
  belongs_to :event
  validates_uniqueness_of :subscription_id, scope: :event_id
end
