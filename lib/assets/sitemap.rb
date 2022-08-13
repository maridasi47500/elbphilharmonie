require "nokogiri"
require "open-uri"
@doc=Nokogiri::HTML(URI.open("https://www.elbphilharmonie.de/en/publications#sitemap"))
@doc.css('.sitemap').css('a').each do |site|
  Sitepage.find_or_create_by(title: site.text.squish.strip, url: site.attributes['href'].value)
end
