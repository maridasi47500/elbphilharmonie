 
def savethisvideo(k,subscription)
  
  
if !k.css('.iframe-spotify') or k.css('.iframe-spotify').empty?
  h=Video.new
  h.overlay=k.css('.open-media-overlay')[0].attributes['href'].value
    h.image=k.css('img')[0].attributes['src'].value
    h.caption=k.css('img')[0].attributes['title'].value
    h.save
h
    subscription.videos << h
  else
  h=Spotify.new
    h.image=k.css('img')[0].attributes['src'].value
    h.caption=k.css('img')[0].attributes['title'].value
    h.iframe=k.css('.iframe-spotify')[0].attributes['src'].value
    h.save
    subscription.spotifies << h      
  end

end