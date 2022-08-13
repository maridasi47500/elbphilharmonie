class Subscriptionshavepromoter < ApplicationRecord
  belongs_to :subscription
  belongs_to :promoter
  validates_uniqueness_of :subscription_id, scope: :promoter_id
end
