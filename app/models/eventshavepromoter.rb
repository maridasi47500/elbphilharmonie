class Eventshavepromoter < ApplicationRecord
  belongs_to :event
  belongs_to :promoter
  validates_uniqueness_of :event_id,scope: :promoter_id
end
