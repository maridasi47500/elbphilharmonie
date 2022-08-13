class Eventcat < ApplicationRecord
  has_and_belongs_to_many :events, :join_table => :eventhavecats
  belongs_to :mycat
  has_many :venuehavehalls
  has_many :surelements, through: :venuehavehalls, source: :othereventcat
translates :name
attr_accessor :someurl
def subelements
  Eventcat.all.joins("left join venuehavehalls e on e.eventcat_id = eventcats.id").select('eventcats.*, e.eventcat_id as myid').group('eventcats.id').having('e.othereventcat_id = ?', self.id)

end
def myelements
  Eventcat.all.joins("left join venuehavehalls e on e.eventcat_id = eventcats.id").select('eventcats.*, e.eventcat_id as myid').group('eventcats.id').having('e.eventcat_id = ?', self.id)

end
def urlchecked(lien)
  lien.split('/').include?(self.url.gsub('/',''))
end
def myurl(mypath)
  path=mypath.split('/')
   
    arr= (self.subelements.select {|x|path.include?(x.url.gsub('/',''))}+ self.surelements.select {|x|path.include?(x.url.gsub('/',''))}) 

    k=path.tally.select{ |k, v| v > 1 }.keys+arr.to_a.map {|h|h.url.gsub('/','')}
    if k.length > 0
    k.each do |l|
    path.delete(l)
    end
    end
  
    self.someurl || path.join('/')
end
def myotherurl2(other)
  path=other.to_s.split('/')
  p path
  arr=self.subelements.select {|x|path.include?(x.url.gsub('/',''))}+ self.surelements.select {|x|path.include?(x.url.gsub('/',''))}
  p arr 
  k=path.tally.select{ |k, v| v > 1 }.keys+arr.to_a.map {|h|h.url.gsub('/','')}
    if k.length > 0
    k.each do |l|
    path.delete(l)
    end
    
    
    
    
    
end
 l= (path+[self.url.gsub('/','')]).join('/')
    p l
    l
end
def myotherurl3(other)
  path=other.split('/')
  
 p path.tally
 path.push(self.url.gsub('/',''))

 
 
    
 
    path.without('').join('/')+"/"
end
def newurl(mypath)
   
  p "=="
  p self.name
  p "==="
 path=mypath.split('/')
 path.push(self.url.gsub('/',''))
 
    k=path.tally.select{ |k, v| v > 1 || k == self.url.gsub('/','') }.keys
 
  p k
    if k.length > 0
    k.each do |l|
      
    p "cle a supprimer du hash"
    p l
    p "hash"
    p path
    path.delete(l)
    p "urlfinal"
    p path.join('/')
    end
    end
    path.join('/')+"/"
end

def myotherurl(mypath)
   
  p "=="
  p self.name
  p "==="
 path=mypath.split('/')
  
 p path.tally
 p self.url
   arr=(self.subelements.select {|x|path.include?(x.url.gsub('/',''))}+ self.surelements.select {|x|path.include?(x.url.gsub('/',''))})

    k=path.tally.select{ |k, v| v > 1 || k == self.url.gsub('/','') }.keys+arr.to_a.map {|h|h.url.gsub('/','')}
 
  p k
    if k.length > 0
    k.each do |l|
      
    p "cle a supprimer du hash"
    p l
    p "hash"
    p path
    path.delete(l)
    p "urlfinal"
    p path.join('/')
    end
    end
 
    self.someurl || path.join('/')
end
def self.findby(y,date)
  p date
mydate= date ? [Eventcat.new(url: date.strftime('%d-%m-%Y')+"/", name: "from "+I18n.l(date.to_date, format: :filter))] : []
deleteall=(y.length > 0 || date) ? [Eventcat.new(url: "", someurl: "/"+I18n.locale.to_s+"/whats-on", name: "Delete all")] : []
  mydate+where(url: y.map {|h| h+'/'})+Venue.where(url: y.map {|h| h+'/'}).map{|h|h.becomes(Eventcat)}+deleteall
end
def self.findevents(y,date)
  rooms1=Venue.where(url: y.map{|h| h+'/'})
  biggerhalls=rooms1.biggerhalls.length == 0 && rooms1.length > 0
  rooms1.each do |room|
    y.delete(room.url.gsub('/',''))
  end
  rooms = rooms1.onlybighalls
  selectvenue=rooms.length > 0 ? rooms.map{|h|"(roomname.name_en = \"#{h.venuename}\" #{biggerhalls ? "and venues.url = \"#{h.url}\"" : ""})"}.join(' or ') : "roomname.name_en is not null"
    !y.blank? ? Event.all.joins(:eventcats).joins(:venue).joins("left outer join venueshavevenues v on v.othervenue_id = venues.id").joins('left outer join venues roomname on roomname.id = v.venue_id or venues.id = roomname.id').select('events.*, sum( case when '+y.map{|h|"eventcats.url = \"#{h}/\""}.join(' and ')+' then 1 else 0 end) as myurl, sum( case when '+y.map{|h|"venues.url = \"#{h}/\""}.join(' and ')+' then 1 else 0 end) as myvenue, sum( case when '+selectvenue+' then 1 else 0 end) as roomnameen, v.venue_id as myvenueid').having('myurl > 0 or myvenue > 0 and roomnameen > 0').group('events.id').having((date ? ["date >= ?", date.to_date] : "")).order(date: :desc).limit(10) :  (date ? Event.all.order(date: :desc).limit(10).group('events.id').having((date ? ["date >= ?", (date ? date.to_date : Date.today)] : "")).joins(:venue).joins("left outer join venueshavevenues v on v.venue_id = venues.id").joins('left outer join venues roomname on roomname.id = v.othervenue_id or venues.id = roomname.id').group("events.id").select('events.*, roomname.name_en as roomnameen1, sum(distinct case when '+selectvenue+' then 1 else 0 end) as roomnameen, v.venue_id as myvenueid').having((!rooms.blank? ? "roomnameen > 0" : "")) : Event.all.order(date: :desc).limit(10).joins(:venue).joins("left outer join venueshavevenues v on v.venue_id = venues.id").joins('left outer join venues roomname on roomname.id = v.othervenue_id or venues.id = roomname.id').group("events.id").select('events.*, roomname.name_en as roomnameen1, sum(distinct case when '+selectvenue+' then 1 else 0 end) as roomnameen, v.venue_id as myvenueid').having((!rooms.blank? ? "roomnameen > 0" : "")))
end
end
