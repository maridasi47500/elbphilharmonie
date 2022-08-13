class Newsletteruser < ApplicationRecord
  belongs_to :user
  belongs_to :newsletter
  validates_uniqueness_of :user_id, scope: :newsletter_id
end
