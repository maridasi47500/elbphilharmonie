class Press < ApplicationRecord
    has_and_belongs_to_many :links, :join_table => :presshaslinks
  before_destroy do
    links.clear
  end

end
