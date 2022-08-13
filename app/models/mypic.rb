class Mypic < ApplicationRecord
  validates_uniqueness_of :image
  has_many :bloghavepictures
  has_many :blogs, through: :bloghavepictures

end
