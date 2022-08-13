class Event < ActiveRecord::Base
  has_and_belongs_to_many :eventcats, :join_table => :eventhavecats
  belongs_to :venue, class_name: "Venue"
  has_one :smallpicture
  has_one :bigpicture
  has_many :booklets
  
 
  has_and_belongs_to_many :festivals, :join_table => :festivalshaveevents
  has_many :eventshavepromoters
  has_many :promoters, through: :eventshavepromoters
  
    has_many :eventshavebroadcasts
  has_many :concert_broadcasts, through: :eventshavebroadcasts
  has_many :eventshaveblogs
  has_many :blogs, through: :eventshaveblogs
  
  has_many :eventshavespotlights
  has_many :spotlights, through: :eventshavespotlights
  
  has_many :videoshaveevents
  has_many :videos, through: :videoshaveevents
  before_validation :setprice
  def setprice
    self.price ||= ""
  end
  def printpast
    if self.date < Date.today
      "past"
    else
      ""
    end
  end
  def self.search(q, typeres)
    case typeres
    when "event"
      upcoming(q)
    when "past_event"
      past(q)
    when "other"
      other(q)
    end
  end
  def self.upcoming(q)
    all.select('*').where(["lower(title) like ? and date >= ?", "%"+q.to_s.gsub(' ','%')+"%", Date.today])
  end
  def self.past(q)
    all.select('*').where("lower(title) like ? and date <= ?", "%"+q.to_s.gsub(' ','%')+"%", Date.today)
  end
  def self.other(q)
    #Blog.where("lower(title) like ?", "%"+q.gsub(' ','%')+"%")
    []
  end
  has_many :supportingprogrammes
  has_many :otherevents, through: :supportingprogrammes, source: :event
  
  has_many :eventhavepieces
  has_many :pieces, through: :eventhavepieces
  
  has_many :eventhaveteasers
  has_many :teasers, through: :eventhaveteasers

  has_many :event_statuses
  
  belongs_to :subscription, optional: true
  def grossersaal
    h=self.venue
    i=h.surelements
    i.length > 0 ? i[0].name : h.name
  end
  def status
    event_statuses.last || self.event_statuses.new(type: "Sale")
  end

  def saved?(eventid)
    Favoriteevent.find_by(event_id: self.id, user_id: eventid)
  end
  has_many :performers
  has_many :musicians, through: :performers
  def image
    read_attribute(:image) || self.bigpicture.try(:url) || self.venue.bigpic.try(:url)
  end
end
