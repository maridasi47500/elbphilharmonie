class Venue < ApplicationRecord
    has_many :venueshavevenues
  has_many :surelements, through: :venueshavevenues, source: :othervenue
translates :name
attr_accessor :someurl
has_one :bigpic
has_one :smallpic
has_many :venueinfos
def self.biggerhalls
  joins('left join venueshavevenues v on v.othervenue_id = venues.id').having('v.id is not null').group("venues.id")
end
def self.onlybighalls
  joins('left outer join venueshavevenues v on v.venue_id = venues.id').joins('left outer join venues venueee on venueee.id = v.othervenue_id or venueee.id = venues.id').select('venueee.name_en as venuename, venues.url').group("venues.id")
end
def subelements
  Venue.all.joins("left join venueshavevenues e on e.venue_id = venues.id").select('venues.*, e.venue_id as myid').group('venues.id').having('e.othervenue_id = ?', self.id)

end
def myelements
  Venue.all.joins("left join venueshavevenues e on e.venue_id = venues.id").select('venues.*, e.venue_id as myid').group('venues.id').having('e.venue_id = ?', self.id)

end
def findthisbiggerroom(name)
  Venue.all.joins("left join venueshavevenues e on e.venue_id = venues.id").joins("left join venues othervenue on e.othervenue_id = othervenue.id").select('venues.*, e.venue_id as myid,e.othervenue_id,  othervenue.name_en').group('venues.id').having('e.venue_id = ? and othervenue.name_en = ?', self.id, name).length > 0

end
def urlchecked(lien)
  lien.split('/').include?(self.url.gsub('/',''))
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
end
