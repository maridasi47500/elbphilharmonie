require "nokogiri"
require "open-uri"
require "./lib/assets/festival"
require "./lib/assets/subscription"
#urls=["https://www.elbphilharmonie.de/en/whats-on/PRS/", "https://www.elbphilharmonie.de/en/whats-on/KM/", "https://www.elbphilharmonie.de/en/whats-on/13-05-2023/NM/", "https://www.elbphilharmonie.de/en/whats-on/13-05-2023/WELT/", "https://www.elbphilharmonie.de/en/whats-on/05-06-2022/EPGS/", "https://www.elbphilharmonie.de/en/whats-on/", "https://www.elbphilharmonie.de/en/whats-on/26-06-2022/JA/EPGS/"]
#Venueinfo.delete_all
#Event.delete_all
#Pic.delete_all
#Performer.delete_all
#EventStatus.delete_all
#Eventhavepiece.delete_all



def savethisevent(url, dontlookfestival = false, mylist=false,dontlookotherevents = false)
@doc = Nokogiri::HTML(URI.open(("https://www.elbphilharmonie.de/"+url).gsub("de//","de/")))
raise "This is an exception" if @doc.title.include?('All Events')
  p @doc.css('#venue').children{|x|x.name == "text"}[0].text.squish.strip.downcase
  p @doc.css('#venue').children{|x|x.name == "strong"}[0].text.squish.strip.downcase
@location=Venue.where('lower(name_en) like ?', "%"+@doc.css('#venue').children{|x|x.name == "b"}[1].children[1].children[1].children[8].text.squish.strip.downcase+'%')[0] rescue nil
@other=Venue.where('lower(name_en) like ?', "%"+@doc.css('#venue').children{|x|x.name == "b"}[1].children[1].children[1].children[5].text.squish.strip.downcase+'%')[0] rescue nil
if @location && !@location.findthisbiggerroom(@other.name)
  

thisroomname=@doc.css('#venue').children{|x|x.name == "b"}[1].children[1].children[1].children[8].text.squish.strip
@location=Venue.where('lower(name_en) like ?', "%"+thisroomname+'%')[1]
@location ||= Venue.create(name_en: thisroomname, url: thisroomname.split(' ').map{|x|x[0]}.join('')+@other.name.split(' ').map{|x|x[0]}.join('')+"/") if !@location
  begin
    @location.surelements << @other
  rescue => e
    p "venue"
    p e.message
  end
    end

@location||=Venue.where('lower(name_en) like ?', "%"+@doc.css('#venue').children{|x|x.name == "b"}[1].children[1].children[1].children[5].text.squish.strip.downcase+'%')[0]
mytitle=mylist.css("img")[0].attributes['alt'].value rescue nil

event=Event.find_or_initialize_by title: mytitle

event.smallpicture.try(:delete)
#p mylist.css("img")[0]
#p mylist.css("img")[0].attributes
#p mylist.css("img")[0].attributes['src']
#p mylist.css("img")[0].attributes['alt']
myurl=mylist.css("img")[0].attributes['src'].value rescue nil
event.smallpicture = Smallpicture.find_or_create_by(url: myurl, title: mytitle)

event.elbid = url.split('#')[0].split('/').without('').last rescue nil


p @location


p @location


p @location
event.venue = @location
event.promoters << @doc.css('.block-promoters').children[1].children.select {|h| h.text.strip.squish.length > 0 rescue nil }.map{|h| Promoter.find_or_create_by(name: h.text.gsub('Promoter:','').squish.strip) }
event.date = @doc.css('time')[0].css('strong')[0].text.squish.strip rescue nil
event.time = @doc.css('time')[0].children.select{|x|x.name == "text"}[1].text.squish.strip rescue nil
p event
event.title = @doc.css('.event-title')[0].text.squish.strip rescue nil
event.subtitle = @doc.css('.event-subtitle')[0].text.squish.strip rescue nil
event.description = @doc.css('.event-detail-content').css('p')[1].text rescue nil
event.save

  
  
  
  instruments=@doc.css('.artists').children.select{|g|g.name=="text" && g.text.squish.strip != ""}.map {|g|g.text.squish.strip}
  artists = @doc.css('.artists').css('b').map {|g|g.text.squish.strip}
  
  
  instruments.each_with_index do |instru,i|
    @music_instru = MusicalInstrument.find_or_create_by(name_de: instru)
    myperformer=Artist.find_or_create_by(name: artists[i])
    @musician=Musician.find_or_create_by(musical_instrument_id: @music_instru.id, artist_id: myperformer.id)
    event.musicians << @musician
  end
event.save
@doc.css('h3').select{|h|h.text.strip.squish == ('Programme')}.each do |piece|
  begin
  event.pieces << Piece.find_or_create_by(name: piece.parent.css('p').inner_html)
  rescue => e
    p "piece"
    e.message
    
  end
end

  
  event.elbid = url.split('#')[0].split('/').without('').last rescue nil
event.save
  if @location
@location.locateelb = !@doc.css('.accordion-title').any?{|h|h.include?('not at the Elb')} if @location
@location.description = @doc.css('#venue').css('p')[0].text if @location
begin
@location.venueinfos.find_or_create_by(mytype: "Entrance", description_en: @doc.css('.accordion-title').select{|x|x.text.include?('Entrance')}[0].parent.css('.accordion-content')[0].text.strip.squish) if @doc.css('.accordion-title').select{|x|x.text.include?('Entrance')}[0]
rescue => e
  p "venue"
  p e.message
end
begin
@location.venueinfos.find_or_create_by(mytype: "Parking", description_en: @doc.css('.accordion-title').select{|x|x.text.include?('parking')}[0].parent.css('.accordion-content')[0].text.strip.squish) if @doc.css('.accordion-title').select{|x|x.text.include?('parking')}[0]
rescue => e
  p "parking"
  p e.message
end
begin
@location.venueinfos.find_or_create_by(mytype: "Location", description_en: @doc.css('.accordion-title').select{|x|x.text.include?('at the Elb')}[0].parent.css('.accordion-content')[0].text.strip.squish) if @doc.css('.accordion-title').select{|x|x.text.include?('at the Elb')}[0]
rescue => e
  p "location"
  p e.message
end
begin
@location.venueinfos.find_or_create_by(mytype: "Arrivaltime", description_en: @doc.css('.accordion-title').select{|x|x.text.include?('Arrival')}[0].parent.css('.accordion-content')[0].text.strip.squish) if @doc.css('.accordion-title').select{|x|x.text.include?('Arrival')}[0]
rescue => e
  p e.message
end
begin
@location.venueinfos.find_or_create_by(mytype: "Cloakrooms", description_en: @doc.css('.accordion-title').select{|x|x.text.include?('Cloak')}[0].parent.css('.accordion-content')[0].text.strip.squish) if @doc.css('.accordion-title').select{|x|x.text.include?('Cloak')}[0]
rescue => e
  p e.message
end
begin
@location.venueinfos.find_or_create_by(mytype: "Accessibility", description_en: @doc.css('.accordion-title').select{|x|x.text.include?('Access')}[0].parent.css('.accordion-content')[0].text.strip.squish) if @doc.css('.accordion-title').select{|x|x.text.include?('Access')}[0]
rescue => e
  p e.message
end
begin
@location.venueinfos.find_or_create_by(mytype: "Photography", description_en: @doc.css('.accordion-title').select{|x|x.text.include?('Photo')}[0].parent.css('.accordion-content')[0].text.strip.squish) if @doc.css('.accordion-title').select{|x|x.text.include?('Photo')}[0]
rescue => e
  p e.message
end
  end
  begin
    @doc.css('.booklet-download').each do |booklet|
      link=booklet.attributes['href'].value
      title=booklet.children.select{|g|g.name == "text"}[0].text
      size=booklet.css('.nobreak')[0].text
      
    end
  rescue => e
    p e.message
    p "error booklet"
  end
    if !dontlookotherevents
@doc.css('h3').select{|x|x.text.include?('Supporting programme')}.each do |programme|
      #events=programme.parent.css('p')
#      events.each do |event|
#        date=events.children.select{|h|h.name == "text"}[0].text.to_date
#        time=events.children.select{|h|h.name == "text"}[0].text.to_time
#        halls=events.children.select{|h|h.name == "text"}[1].text.split(',')
#        biggerhall=halls[1]
#        smallerhall=halls[2]
#      end
      myeventurl="https://www.elbphilharmonie.de"+programme.css('.anchor-module').css('.link-default')[0].attributes['href'].value
      otherevent=savethisevent(myeventurl,false,false,true)
      event.otherevents << otherevent if otherevent
    end
    end
    @doc.css('h3').select{|x|x.text.downcase.include?('schwerpunkt') }.each do |programme|
      
      myeventurl="https://www.elbphilharmonie.de"+programme.css('.anchor-module').css('.link-default')[0].attributes['href'].value rescue nil
      p myeventurl
      otherevent=savethisfestival(myeventurl)
      event.spotlights << otherevent if otherevent
    end
    if !dontlookfestival
    @doc.css('h3').select{|x|x.text.downcase.include?('festival') }.each do |programme|
      
      myeventurl="https://www.elbphilharmonie.de"+programme.parent.css('.anchor-module').css('.link-default')[0].attributes['href'].value
      p myeventurl
      otherevent=savethisfestival(myeventurl)
      event.festivals << otherevent if otherevent
    end
    end
    
  @doc.css('h3').select{|x|x.text.include?('Subscription') }.each do |subscription|
   
      mysubscriptionurl="https://www.elbphilharmonie.de"+subscription.css('.anchor-module').css('.link-default')[0].attributes['href'].value
      othersubscription=savethissubscription(mysubscriptionurl)
      event.subscriptions << othersubscription if othersubscription
      event.save
    end
  @doc.css('h3').select{|x|x.text.include?('Series') }.each do |subscription|
   
      mysubscriptionurl=("https://www.elbphilharmonie.de"+subscription.css('.anchor-module').css('.link-default')[0].attributes['href'].value) rescue nil
      othersubscription=savethissubscription(mysubscriptionurl) rescue mysubscriptionurl
      event.series << othersubscription if othersubscription
      event.save
  end
    concert=@doc.css('#livestream-concert')
    if concert
      concert.css('p').each do |b|
        Broadcast.find_or_create_by(description: b.inner_html)
      end
    end
event.bigpicture.try(:delete)
event.bigpicture = Bigpicture.find_or_create_by(url: @doc.css('figure.slide')[0].css("img")[0].attributes['src'].value, title: @doc.css('figure.slide')[0].css("img")[0].attributes['title'].value) if @doc.css('.accordion-title').select{|x|x.text.include?('Arrival')}[0]
event.save
  @doc.css('.cell.medium-6').select{|g|g.text.include?('Estimated end time')}.each do |cell|
  begin
      event.endtime=cell.css('p').text
      event.save
  rescue => e
  end
    end
if @location
@location.smallpic.try(:delete)
@location.smallpic = Smallpic.find_or_create_by(url: @doc.css('figure.image-module')[0].css("img")[0].attributes['src'].value, title: @doc.css('figure.image-module')[0].css("img")[0].attributes['title'].value) if @doc.css('.accordion-title').select{|x|x.text.include?('Arrival')}[0]

@location.save
end
def hackteaser(a)
  otherurl="https://www.elbphilharmonie.de"+a
@doc2=Nokogiri::HTML(URI.open(otherurl))

  
end
begin
  @doc.css('.slick-track')[1].children.each do |teaser|
    image=teaser.search('.bigteaser__figure').map{ |n| n['style'][/url\((.+)\)/, 1] }
    subtitle=teaser.css('.bigteaser__subtitle').text
    title=teaser.css('.bigteaser__title').text
    linktext=teaser.css('.link-default').text
    urlteaser=teaser.css('a').attributes['href'].value.split('#')[0].split('/').last
    @teaser= Teaser.find_or_create_by(image: image, subtitle: subtitle, title: title, link: linktext)
    begin
      event.teasers << @teaser
    rescue => e
      p e.message
    end
    hackteaser(urlteaser)
  end
rescue => e
end
  #price
  #event.presale
#  @cancelledprices=@doc.css('.status-box').css('.prices').css('strike').map(&:text)
#  @goodprices=@doc.css('.status-box').css('.prices').css('span').select{|x|!x.text.include?('€')}.map(&:text)
#  event.price=@prices.length == 0 ? @doc.css('.status-box').css('.prices').css('span').last : @prices.join(' | ')
  #@linkbuyticket=@doc.css('.ticket-and-prices').css('.link-ticket').attributes['href'].value #buy ticket path
  
  event.save
  @event=event
begin
  @buylaterticket=@doc.css('.event-status').css('.future-status').css('.status')[0].text rescue nil
  @buyticketlater_selling_date=@doc.css('.event-status').css('.future-status').css('.status-sub').text rescue nil
  @buyticketlater_prices=@doc.css('.event-status').css('.future-status').css('.prices').css('span').select{|x|!x.text.include?('€')}.map(&:text).join(' | ') rescue nil
  @buyticketlater_infos=@doc.css('.event-status').css('.future-status').css('.status-sub')[1..-1].map(&:text).join("\n") rescue nil
  @status=event.event_statuses.create(type: "Future",status: @buylaterticket, status_sub: @buyticketlater_selling_date.to_s+"\n"+@buyticketlater_infos.to_s)
  event.price = @buyticketlater_prices
  @status.destroy if !@status.persisted?
rescue => e
  p "future"
  p e.message
end

begin
  @soldoutmessage =@doc.css('.event-status').css('.soldout-status').css('.status-sub').text rescue nil
  @linksoldout=@doc.css('.event-status').css('.link-sold-out').text rescue nil
  @soldoutprice=@doc.css('.event-status').css('.soldout-status').css('.prices').css('strike').select{|x|!x.text.include?('€')}.map(&:text) rescue nil
@status=event.event_statuses.create(type: "Soldout", status_sub: @soldoutmessage)
@status.destroy if !@status.persisted?
 event.price = @externalshop_price

rescue =>e
  p "soldout"
  p e.message
end

begin
@externalshopinfo=@doc.css('.event-status').css('.external-info-status').css('.status-sub') rescue nil
@externalshopwebsite=@doc.css('.event-status').css('.external-info-status').css('.status-sub').css('a')[0].attributes['href'].value rescue nil
@externalshop_price=@doc.css('.event-status').css('.external-info-status').css('.prices').css('span').select{|x|!x.text.include?('€')}.map(&:text).join(' | ') rescue nil 
@status=event.event_statuses.create(website: @externalshopwebsite,type: "ExternalInfo", status_sub: @externalshopinfo)
 event.price =   @soldoutprice
@status.destroy if !@status.persisted?
rescue => e
  p "external shop"
  p e.message
end

begin
  
@unavailableticket_messageimportant=@doc.css('.event-status').css('.unavailable-status').css('.status')[0].text rescue nil
  @unavailableticket_cancelledprices=@doc.css('.event-status').css('.unavailable-status').css('.prices').css('strike').select{|x|!x.text.include?('€')}.map(&:text).join(' | ') rescue nil
  
@unavailableticket_message=@doc.css('.event-status').css('.unavailable-status').css('.status-sub')[0].text rescue nil
@status=event.event_statuses.create(type: "Unavailable", status_sub: @unavailableticket_message, status: @unavailableticket_messageimportant)
 event.price = @unavailableticket_cancelledprices
@status.destroy if !@status.persisted?
rescue => e
  p "unavailable"
  p e.message
end
  
begin
  
@limitedticket_messageimportant=@doc.css('.event-status').css('.residue-status').css('.status')[0].text rescue nil
  @limitedticket_prices=@doc.css('.event-status').css('.residue-status').css('.prices').css('span').select{|x|!x.text.include?('€')}.map(&:text).join(' | ') rescue nil
 @status = event.event_statuses.create(type: "Residue", status: @limitedticket_messageimportant)
 event.price = @limitedticket_prices
 @status.destroy if !@status.persisted?
rescue => e
  p "residue"
  p e.message
end

begin
  
  @saleticket_prices=@doc.css('.event-status').css('.sale-status').css('.prices').css('span').select{|x|!x.text.include?('€')}.map(&:text).join(' | ') rescue nil
   @ticket_prices=@doc.css('.event-status').css('.sale-status').css('.prices').css('span').select{|x|!x.text.include?('€')}.map(&:text).join(' | ') rescue nil

  event.price = @ticket_prices
@status.destroy if !@status.persisted?
rescue => e
  p "sale"
  p e.message
end
event.save  
return event
rescue => e
p e.message
(event rescue nil) || nil

end






#
#urls.each do |thisurl|
#@doc1=Nokogiri::HTML(URI.open(thisurl))
#
#
#
#@doc1.css('.event-image-link').each do |mylist|
##myurl="https://www.elbphilharmonie.de/en/whats-on/prufungskonzert/18160"
#
#  
#myurl="https://www.elbphilharmonie.de"+mylist.attributes['href'].value
#p myurl
#  savethisevent(myurl)
#rescue => e
#  p e.message
#  next
#end
#end

def allevents
  #2021 , 2022
  urls=["https://www.elbphilharmonie.de/en/whats-on/"]
  
  #saison1 2022
  urls.each do |url|
    doc1=Nokogiri::HTML(URI.open(url))
    
    doc1.css(".event-title").each do |link|
      p link.css('a')[0].attributes['href'].value
      savethisevent(link.css('a')[0].attributes['href'].value)
    rescue => e
      p e.message
      next
    end
  end
  #saison2 2021
  
  
end
