require "./lib/assets/subscription"
require "./lib/assets/mediatheque"
require "./lib/assets/myevent"
require "./lib/assets/savevideo"
def savethisfestival(url,myid = nil)
  mylocation='https://www.elbphilharmonie.de'
  if !url.include?(mylocation)
    url=mylocation+url
  end
festival=(myid ? Festival.find(myid) : Festival.new) rescue Festival.new
doc = Nokogiri::HTML(URI.open(url))
festival.elbid=myid||url.split('#')[0].split('/').last
time=doc.css('time').text.split(' – ')
festival.begindate=time[0]
    festival.enddate=time[1]
    festival.title=doc.css(".event-title")[0].text
    festival.subtitle=doc.css(".event-subtitle.subline")[0].text
    festival.description=doc.css('.event-detail-content').css('p')[0].text+doc.css('.event-detail-content').css('.readmore-text').css('p').map{|x|x.text}.join(' \n')
  @doc=doc
  p doc.css(".festival-image")
  festival.image1=doc.css(".festival-image").attributes["src"].value  rescue nil
  
  festival.image2=doc.css(".slideshow-event").css('img')[0].attributes["src"].value rescue nil
  festival.save
  festival.promoters << doc.css('.block-promoters').children[1].children.select {|h| h.text.strip.squish.length > 0 rescue nil }.map{|h| Promoter.find_or_create_by(name: h.text.gsub('Supported by ','').gsub('Promoter:','').squish.strip) }
p "festivals events"
begin
  festival.events << doc.css('.booking-list-page').css('[data-event-id]').map do |h| 
  dontlookfestivals=true
  mylist = h.css('.event-title').css('a') rescue nil
   savethisevent(mylist[0].attributes['href'].value, dontlookfestivals,mylist[0],true) if mylist[0]
  rescue => e
    p mylist[0].attributes['href'].value
    p e.message
    next 
end
rescue => e
p e.message
p "error events"
  end
p "festival supporting programmes"
begin
festival.supportingprogrammes << doc.css('h2').select{|h|h.include?('Supporting programme')}[0].parent.parent.parent.css('[data-event-id]').select.map do |h| 
  dontlookfestivals=true
  p h.css('.event-title').css('a') rescue nil
   savethisevent(h.css('.event-title').css('a')[0].attributes['href'].value, dontlookfestivals,h.css('.event-title').css('a')[0])
end
rescue => e
  p e.message
  p "error in supporting programes"
end
#festival have videos
begin
p "festivals have videos"
doc.css('.video-module').each do |item|
  savethisvideo(item,festival)
end
rescue =>e
  p e.message
  p "error in festivals"
end
begin
#festival have mediatheque
p "blog teasers"
doc.css('.blog-teasers').css('.blog__item').each do |item|
  p item.css('.detail-link') rescue nil
  festival.blogs << savethismediatheque(item.css('.detail-link').attributes['href'].value)
end
rescue => e
  p e.message
  p "error in blog teasers"
end
p "evets"
begin
  #festival have events
  doc.css('.event-list').css('.event-item').each do |event|
    p event.css('.event-title').css('a') rescue nil
  dontlookfestivals = true
  festival.events << savethisevent(event.css('.event-title').css('a')[0].attributes['href'].value, dontlookfestivals,mylist[0],true)
  end
  
rescue => e
  p e.message
  
end
  festival
rescue
  nil
end

def festivals_from_seasons
  #2021 , 2022
  urls=["https://www.elbphilharmonie.de/en/season","https://www.elbphilharmonie.de/en/2020-21_season"]
  
  #saison1 2022
  urls.each do |url|
    doc1=Nokogiri::HTML(URI.open(url))
    doc1.xpath("//a[contains(@href, '/series/')]").each do |link|
      savethisfestival(link.attributes['href'].value)
    rescue => e
      p e.message
      next
    end
  end
  #saison2 2021
  
  
end
