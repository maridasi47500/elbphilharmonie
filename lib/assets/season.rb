require "nokogiri"
require "open-uri"
@doc=Nokogiri::HTML(URI.open("https://www.elbphilharmonie.de/en/season"))
@titres=@doc.css('h2.headline-module')
@doc.css('.teaser-list-module').each_with_index do |k,i|
  k.css('.teaser-item').each do |l|
    @l=l
    m=Highlight.create do |t|
      t.image=l.css('img')[0].attributes['src'].value
      t.imagecaption=l.css('img')[0].attributes['alt'].value
      t.title=l.css('h3').text.strip.squish
      t.content=l.css('h3').text.strip.squish
      t.url=l.css('.teaser-image-link')[0].attributes['href'].value
      t.category=@titres[i].text
      
    end
  end
end