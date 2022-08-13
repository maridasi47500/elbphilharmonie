class Newsletter < ApplicationRecord
  has_many :newsletterusers
  has_many :users
  attr_accessor :list
  translates :name
  translates :description
  def name_and_description
    [self.name, self.description]
  end
end
