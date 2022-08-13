require "nokogiri"
require "open-uri"
Mycat.delete_all
Eventcat.delete_all
Venue.delete_all
Venuehavehall.delete_all
Venueshavevenue.delete_all
url="https://www.elbphilharmonie.de/en/whats-on/20-05-2022/EXF/KM/KLAV/EPHH/KON/LTT/"
@doc = Nokogiri::HTML(URI.open(url))
@doc.css('.filter__option').each do |data|
  
  @type=Mycat.find_or_create_by(name_en: data.attributes['data-name'].value)
  p @type
  if @type.name == "Venue"
    data.css('.filter__item').each do |data2|

    n= data2.css('a')[0].attributes
    name=n['data-name'].value
    p name
    url=n['href'].value
    p url
    @mytype=Venue.create(name_en: name,url: url.split('/').without('').last+"/")
    if !data2.attributes['class'].value.include?('filter__item--subelement')
      @type1=@mytype
    else
      @mytype.surelements << @type1
    end
  
  rescue => e
    p e.message
    next
  end
  else
  
  data.css('.filter__item').each do |data2|

    n= data2.css('a')[0].attributes
    name=n['data-name'].value
    p name
    url=n['href'].value
    p url
    @mytype=@type.eventcats.create(name_en: name,url: url.split('/').without('').last+"/")
    if !data2.attributes['class'].value.include?('filter__item--subelement')
      @type1=@mytype
    else
      @mytype.surelements << @type1
    end
  
  rescue => e
    p e.message
    next
  end
  end
rescue => e
  p e.message
  next

end
