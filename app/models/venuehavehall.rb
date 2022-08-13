class Venuehavehall < ApplicationRecord
  belongs_to :eventcat
  belongs_to :othereventcat, class_name: "Eventcat"
  validates_uniqueness_of :eventcat_id, scope: :othereventcat_id
end
