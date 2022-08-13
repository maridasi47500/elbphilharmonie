class Contenthaveheadline < ApplicationRecord
  belongs_to :content
  belongs_to :headline
  validates_uniqueness_of :content_id, scope: :headline_id
end
