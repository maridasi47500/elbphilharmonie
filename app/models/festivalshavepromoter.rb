class Festivalshavepromoter < ApplicationRecord
  belongs_to :festival
  belongs_to :promoter
  validates_uniqueness_of :festival_id, scope: :promoter_id
end

