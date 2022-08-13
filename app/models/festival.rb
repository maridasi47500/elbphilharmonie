class Festival < ApplicationRecord
  has_many :festivalshavevideos
  has_many :videos, through: :festivalshavevideos
  has_many :festivalshavespotifies
  has_many :spotifies, through: :festivalshavespotifies
  has_many :festivalshavepromoters
  has_many :promoters, through: :festivalshavepromoters
  has_many :festivalshaveblogs
  has_many :blogs, through: :festivalshaveblogs
  has_and_belongs_to_many :events, :join_table => :festivalshaveevents
  has_and_belongs_to_many :supportingprogrammes, class_name: "Event", :join_table => :festivalshavesupportingprogrammes
  before_validation :saveurl
  def saveurl
    self.url=self.title.parameterize
  end
end
