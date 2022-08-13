class Video < ApplicationRecord
  
  has_many :subscriptionshavevideos
  has_many :subscriptions, through: :subscriptionshavevideos
  has_many :videoshaveevents
  has_many :events, through: :videoshaveevents
  has_many :festivalshavevideos
  has_many :festivals, through: :festivalshavevideos
end
