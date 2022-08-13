require "nokogiri"

require "open-uri"
@doc=Nokogiri::HTML(URI.open("https://www.elbphilharmonie.de/en/"))

@doc.css('.highlights__item').each do |k|
  t=Highlight.find_or_initialize_by title: k.css('h3').text.strip.squish
  
    t.begindate=k.css('.preline').text.gsub('until',' - ').split(' - ')[0].to_date rescue nil
      t.enddate=k.css('.preline').text.gsub('until',' - ').split(' - ')[1].to_date rescue nil
      
    t.url=k.css('a').last.attributes['href'].value rescue nil
    t.imageurl=k.css('.highlights__link').attributes['href'].value rescue nil
      t.content=k.css('p').text
      t.image=k.css('.highlights__image').attributes['src'].value rescue nil
      t.imagecaption=k.css('.highlights__image').attributes['alt'].value rescue nil
      t.subtitle=k.css('.preline').text.strip.squish
      t.mylabel=Mylabel.find_or_create_by(name: k.css('.link-default').text)
      t.category=k.attributes['data-category'].value
  t.save 
rescue => e
  p e.message
    
  next
end
@doc.css('.bigteaser__list').children.each do |k|
    p k.css('.bigteaser__figure')
    h=Teaser.create do |t|
      t.category=k.css('[data-category]')[0].attributes['data-category'].value
      t.title=k.css('.bigteaser__title').text.strip.squish
    t.url=k.css('.link-default').attributes['href'].value rescue nil
      t.image=URI.extract((k.css('.bigteaser__figure')[0].attributes['data-background'].value rescue nil),%w[http https])[0]
      t.subtitle=k.css('.bigteaser__subtitle').text.strip.squish rescue nil
      t.mylabel=Mylabel.find_or_create_by(name: k.css('.home-slider-button').text)
  end 
rescue => e
  p e.message
  next
end

@doc.css('.swiper-wrapper').children.each do |k|
  p k
    h=Teaser.create do |t|
      t.title=k.css('.bigteaser__title').text.strip.squish
    t.url=k.css('.link-default')[0].attributes['href'].value rescue nil
      t.image=URI.extract((i.attributes['style'].value rescue nil),%w[http https])[0]
      t.mylabel=Mylabel.find_or_create_by(name: k.css('.link-default')[0].text)
  end 
rescue => e
  p e.message
  next
end