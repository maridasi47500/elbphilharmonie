require "nokogiri"

require "open-uri"
require "./lib/assets/eventstatus"

@doc=Nokogiri::HTML(URI.open("https://www.elbphilharmonie.de/en/participate"))
@category=@doc.css(".abos__genre-title")
@years=@doc.css("span.h4")
@doc.css('ul.grid-margin-x').each_with_index do |projets,i|
  

  projets.css('li').each do |a|
    registerendproj=(!a.css('.status').try(:text).include?('Registration currently not possible') rescue nil) ? (a.css('.status').try(:text).try(:gsub, "Register by","").to_date rescue nil) : nil
    @musicproject=Musicproject.create do |t|
      @a=a
        t.title=a.css('h3').text.strip.squish
        t.image=a.css('img')[0].attributes['src'].value
        t.image=a.css('img')[0].attributes['alt'].value
      t.subtitle=@category
      t.year=@years[i].text
      t.mytype=@category[i].text
      t.registerstart=nil
      t.registerend= registerendproj
      t.start=nil
      t.end=nil
      t.description=a.css('p').inner_html
      t.event_status_id=nil
end
  end
  
end
