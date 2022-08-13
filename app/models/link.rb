class Link < ApplicationRecord
  validates_uniqueness_of :link, scope: :name
  has_and_belongs_to_many :press, :join_table => :presshaslinks
  before_destroy do
    press.clear
  end
end
