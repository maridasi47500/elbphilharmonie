class Teaser < ApplicationRecord
  has_many :eventhaveteasers
  has_many :events, through: :eventhaveteasers
  belongs_to :mylabel
  def self.swiper
    Teaser.where(category: nil).last(3)
  end
  def self.teaser
    Teaser.where.not(category: nil).last(16)
  end

end
