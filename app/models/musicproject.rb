class Musicproject < ApplicationRecord
  has_and_belongs_to_many :events,:join_table => :musicprojectshaveevents
  has_and_belongs_to_many :blogs,:join_table => :musicprojectshaveblogs
  has_and_belongs_to_many :mypics,:join_table => :musicprojectshavephotos
  has_and_belongs_to_many :promoters,:join_table => :musicprojectshavepromoters
  belongs_to :event_status,optional: true
  def self.myprojects
    all.where(year: ["2022/23","2021/22"]).order(:created_at => :desc, :mytype => :asc).group_by{|x|[x.year, x.mytype]}
  end
  def registernow?
    registerstart <= Date.today || registerend >= Date.today
  end
end
