class Subscription < ApplicationRecord
  has_many :subscriptionshavevideos
  has_many :videos, through: :subscriptionshavevideos
  has_many :subscriptionshavepromoters
  has_many :promoters, through: :subscriptionshavepromoters
  
  has_many :spotifieshavesubscriptions
  has_many :spotifies, through: :spotifieshavesubscriptions
end
