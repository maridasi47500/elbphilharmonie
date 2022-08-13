require "nokogiri"
require "open-uri"
def savethismediatheque(url)
  location="https://www.elbphilharmonie.de"
  if !url.include?(location)
    url=location+url
  end
  doc=Nokogiri::HTML(URI.open(url))
  mediatheque=Blog.new
 
  mediatheque.title=doc.css('.blog-detail__title').text
  mediatheque.subtitle=doc.css('.blog-detail__description').text
  mediatheque.save
   if doc.css('.blog-detail__play--demand')[0]
    p "live stream"
    dates=doc.css('.blog-detail__sub-title').text.gsub('on demand',"").gsub('from',"").gsub('soon',"").gsub('Video on demand from',"").gsub('available until'," -- ").split(" -- ")
    videourl=doc.css('.blog-detail__play--demand')[0].attributes['href'].value
    mediatheque.livestreams.find_or_create_by(url:  videourl,begins: (dates[0].strip.squish rescue nil), "ends" => (dates[1].strip.squish rescue nil))
    
  end
  doc.css('.grid-container.section-container').each do |s|
    
    s.css('.cell').each do |cell|
      @cell=cell
      k= cell.attributes['class'].value
      mycontentname=cell.xpath("//div[contains(@class, '-module')]")
      if k.include?('.large-order-1') #case gauche
        mycontent=nil
        orderno=1
        elsif k.include?('.large-order-2') #case milieu
  
      mycontent=nil
      orderno=2
      
      mycontentname.each do |contentname|
      if contentname.attributes['class'].value.include?("video-module")
    myvid=contentname.css('.video-module')
      overlay=myvid.css('.open-media-overlay').attributes['src'].value
        image=myvid.css('img').attributes['src'].value
        caption=myvid.css('.image-caption').text
      video=Video.find_or_create_by(overlay: overlay, image: image, caption: caption)
      
      mycontent=mediatheque.contents.create!(myorder: orderno)
      mycontent.videos << video
      
    elsif contentname.attributes['class'].value.include?("headline-module") && contentname.name == "h3"
      h=contentname.css('.headline-module')
      someurl=h.attributes['href'].value
      if someurl != url
        
      littlepic=h.css('img').attributes['src'].value
      littlepictitle=h.css('img').attributes['title'].value
        shortsubtitle=h.css('.link-default').text
      mycontent=mediatheque.contents.create!(myorder: orderno)
      mycontent.blogs << Blog.find_or_create_by(url: someurl,littlepictitle:  littlepictitle, littlepic: littlepic,shortsubtitle: shortsubtitle)
      end
    elsif contentname.attributes['class'].value.include?("anchor-module")
    cell.css('.anchor-module').xpath("//a[contains(@href, '/mediatheque/')]").each do |link|
      mycontent ||= mediatheque.contents.create!(myorder: orderno)
      mycontent.mediathequelinks << savethismediatheque(link.attributes['href'].value)
      
    end
    elsif contentname.attributes['class'].value.include?("quote-module")
      mycontent ||= mediatheque.contents.create!(myorder: orderno)
      mycontent.othercontents.find_or_create_by(type:"Quote", content: contentname.text)
      end
      end
          elsif k.include?('.large-order-3') #case droite
            mycontent=nil
            orderno="3"
            mycontentname.each do |contentname|
    if contentname.attributes['class'].value.include?("text-module") 
      
      mycontent||=mediatheque.contents.create!(myorder: orderno)
      mycontent.othercontents << Text.find_or_create_by(content: contentname.text)
      elsif contentname.attributes['class'].value.include?("anchor-module")
    cell.css('.anchor-module').xpath("//a[contains(@href, '/series/')]").each do |link|
      mycontent ||= mediatheque.contents.create!(myorder: orderno)
      mycontent.series << savethisseries(link.attributes['href'].value)
    end
     
    
      end

      end
            end
      
      
    end
    
    
  end
  begin 
    doc.css('.blog-detail__tag').each do |t|
      tag=Tag.find_or_create_by(url: t.css('a')[0].attributes['href'].value.split('/').last,name: t.text.strip.squish)
      mediatheque.tags << tag
    rescue => e
    end
  rescue => e
  end
  mediatheque  
  
end
