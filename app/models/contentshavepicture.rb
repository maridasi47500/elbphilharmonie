class Contentshavepicture < ApplicationRecord
  belongs_to :content
  belongs_to :mypic
  validates_uniqueness_of :content_id,scope: :mypic_id
  
end
