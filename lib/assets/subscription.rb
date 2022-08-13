require "open-uri"
require "nokogiri"
require "./lib/assets/savevideo"
def savethissubscription(url)
  @doc = Nokogiri::HTML(URI.open(url))
title=@doc.css('h1.event-title').try(:text).try(:strip).try(:squish)
elbid=url.split('/').last
subtitle=@doc.css('p.event-subtitle.subline').try(:inner_html).try(:strip).try(:squish)
desc=@doc.css('p')[1].try(:inner_html)

      if @doc.css('.link-ticket')
subscription = Subscription.find_or_create_by(title: title, elbid: elbid,subtitle: subtitle,description: desc)
      else
subscription = ConcertSeries.find_or_create_by(title: title, elbid: elbid,subtitle: subtitle,description: desc)

      end
    subscription.promoters << @doc.css('.block-promoters')[0].try(:children).to_a.select {|h| h.name == "p" rescue nil }.map{|h| Promoter.find_or_create_by(name: h.text.gsub('Promoter:','').squish.strip) }

  @doc.css('.video-module').each do |k|
    savethisvideo(k,subscription)
  
  
end
subscription
end

def subscription_from_seasons
   saison = ["https://www.elbphilharmonie.de/en/subscriptions","https://www.elbphilharmonie.de/en/season-2021-22"]
  saison.each do |s|
    @saison = Nokogiri::HTML(URI.open(s))
    @saison.css("[href*='/en/series']").each do |url|
      myurl="https://www.elbphilharmonie.de"+url.attributes['href'].value
      savethissubscription(myurl)
    rescue RuntimeError => e
      p e.message
      next
    end
  end
end
#subscription_from_seasons