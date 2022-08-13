class Promoter < ApplicationRecord
  has_many :eventshavepromoters
  has_many :events, through: :eventshavepromoters
  
    has_many :subscriptionshavepromoters
  has_many :subscriptions, through: :subscriptionshavepromoters
  has_many :festivalshavepromoters
  has_many :festivals, through: :festivalshavepromoters
end
