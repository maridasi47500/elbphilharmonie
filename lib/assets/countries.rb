require "nokogiri"
@doc = Nokogiri::HTML(File.read("./_countries.html.erb"))
@doc.css('option').each do |o|
  k=Country.find_or_create_by(name: o.text.strip.squish)
  k.update(myvalue: o.attributes['value'].value.gsub('string:',''))
end
Country.find_by(name: 'Country').delete
Country.find_by(name: '--------------------').delete
