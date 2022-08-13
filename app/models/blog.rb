class Blog < ApplicationRecord
  self.table_name="blogs"
    has_many :festivalshaveblogs
  has_many :festivals, through: :festivalshaveblogs
has_many :livestreams

  has_many :bloghavepictures
  has_many :mypics, through: :bloghavepictures
      has_and_belongs_to_many :contents, :join_table =>:blogshavecontents 
has_many :videolinks, through: :contents, source: :videolinks
has_many :blogshavetags
has_many :tags, through: :blogshavetags
def self.firstblog
  all.offset(Blog.all.count - 9).limit(1)[0]
end
def self.myblogs
all.offset(Blog.all.count - 8).limit(4)
end
end
