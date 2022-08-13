class Content < ApplicationRecord
  #validates_uniqueness_of :content
      has_and_belongs_to_many :videos, :join_table => :contentshavevideos
      has_and_belongs_to_many :bloglinks, class_name: "Video", :join_table => :contentshavebloglinks
      has_and_belongs_to_many :blogs,:join_table => :contentshaveblogs
      has_many :othercontents
      has_and_belongs_to_many :series, class_name: "ConcertSeries", :join_table => :contentshaveseries
      has_many :contentshavepictures
      has_many :mypics, through: :contentshavepictures
      has_many :contenthaveheadlines
      has_many :headlines, :through => :contenthaveheadlines, source: :headline
      has_many :contenthavelinks
      has_many :links, :through => :contenthavelinks
      has_many :contenthavetexts
      has_many :texts, :through => :contenthavetexts
before_destroy do 
  videos.clear 
  blogs.clear 
  series.clear
  othercontents.clear
end
end

