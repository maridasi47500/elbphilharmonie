require "nokogiri"
require "open-uri"

#download cms article

@links=['https://www.elbphilharmonie.de/en/the-halls#elbphilharmonie']
@links.each do |link|
@urlarticle=link

@doc=Nokogiri::HTML(URI.open(@urlarticle))
#recup header
@blog=Blog.new do |t|
    t.title=@doc.css('h1').text.strip.squish
    t.subtitle=@doc.css('.description-bold').text.strip.squish
    t.shortsubtitle=""
    t.littlepic=""
    t.littlepictitle=""
    t.image=@doc.css('header').css('img')[0].attributes['src'].value
    t.description=""
    t.url=@urlarticle
end
@blog.save
@doc.css('.grid-container.section-container.with-spacer').each_with_index do |h,y|
  @content=@blog.contents.new(myorder: y)
  @content.save
  h.css('.cell').each do |cell|
    p "cell1"
    large=cell.attributes['class'].value.split(' ').select{|x|x.include?('large-')}[0].gsub('large-','').to_i rescue nil
    cell.children.select{|h|h}.each_with_index do |m,i|
      p "cell"
      p m
      next if !m.attributes['class']
      case m.attributes['class'].value 
      when 'headline-module'
        @item=@content.headlines.find_or_create_by(large: large,textcontent: m.text)
         
        @content.contenthaveheadlines.last.myorder =i
      when  'image-module'
        @item=@content.mypics << Mypic.find_or_create_by(image: m.css('img').attributes['src'].value)
        @content.contentshavepictures.last.myorder = i
      when  'text-module'
        @item=@content.texts << Text.find_or_create_by(image: m.text)
        @content.contenthavetexts.last.myorder = i
      when  'anchor-module'
        @item=@content.links << Link.find_or_create_by(image: m.css('a').attributes['href'].value)
        @content.contenthavelinks.last.myorder = i
      when  'anchor-module'
        @item=@content.quotes << Quote.find_or_create_by(text: m.text.squish.strip)
        @content.contenthavelinks.last.myorder = i
      when  'list-module'
        m.css('.link').each do |mylink|
        @item=@content.links << Link.find_or_create_by(image: mylink.css('a').attributes['href'].value)
        @content.contenthavelinks.last.myorder = i
        
        end
      end
      
    end
  rescue => e
    p e.message
  end
end
end
