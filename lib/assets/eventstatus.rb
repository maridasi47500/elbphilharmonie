
def mystatus(myevent)
begin
  @buylaterticket=myevent.css('.future-status').css('.status')[0].text rescue nil
  @buyticketlater_selling_date=myevent.css('.future-status').css('.status-sub').text rescue nil
  @buyticketlater_prices=myevent.css('.future-status').css('.prices').css('span').select{|x|!x.text.include?('€')}.map(&:text).join(' | ') rescue nil
  @buyticketlater_infos=myevent.css('.future-status').css('.status-sub')[1..-1].map(&:text).join("\n") rescue nil
  @status=event.event_statuses.create(type: "Future",status: @buylaterticket, status_sub: @buyticketlater_selling_date.to_s+"\n"+@buyticketlater_infos.to_s)
  event.price = @buyticketlater_prices
  @status.destroy if !@status.persisted?
rescue => e
  p "future"
  p e.message
end

begin
  @soldoutmessage =myevent.css('.soldout-status').css('.status-sub').text rescue nil
  @linksoldout=myevent.css('.link-sold-out').text rescue nil
  @soldoutprice=myevent.css('.soldout-status').css('.prices').css('strike').select{|x|!x.text.include?('€')}.map(&:text) rescue nil
@status=event.event_statuses.create(type: "Soldout", status_sub: @soldoutmessage)
@status.destroy if !@status.persisted?
 event.price = @externalshop_price

rescue =>e
  p "soldout"
  p e.message
end

begin
@externalshopinfo=myevent.css('.external-info-status').css('.status-sub') rescue nil
@externalshopwebsite=myevent.css('.external-info-status').css('.status-sub').css('a')[0].attributes['href'].value rescue nil
@externalshop_price=myevent.css('.external-info-status').css('.prices').css('span').select{|x|!x.text.include?('€')}.map(&:text).join(' | ') rescue nil 
@status=event.event_statuses.create(website: @externalshopwebsite,type: "ExternalInfo", status_sub: @externalshopinfo)
 event.price =   @soldoutprice
@status.destroy if !@status.persisted?
rescue => e
  p "external shop"
  p e.message
end

begin
  
@unavailableticket_messageimportant=myevent.css('.unavailable-status').css('.status')[0].text rescue nil
  @unavailableticket_cancelledprices=myevent.css('.unavailable-status').css('.prices').css('strike').select{|x|!x.text.include?('€')}.map(&:text).join(' | ') rescue nil
  
@unavailableticket_message=myevent.css('.unavailable-status').css('.status-sub')[0].text rescue nil
@status=event.event_statuses.create(type: "Unavailable", status_sub: @unavailableticket_message, status: @unavailableticket_messageimportant)
 event.price = @unavailableticket_cancelledprices
@status.destroy if !@status.persisted?
rescue => e
  p "unavailable"
  p e.message
end
  
begin
  
@limitedticket_messageimportant=myevent.css('.residue-status').css('.status')[0].text rescue nil
  @limitedticket_prices=myevent.css('.residue-status').css('.prices').css('span').select{|x|!x.text.include?('€')}.map(&:text).join(' | ') rescue nil
 @status = event.event_statuses.create(type: "Residue", status: @limitedticket_messageimportant)
 event.price = @limitedticket_prices
 @status.destroy if !@status.persisted?
rescue => e
  p "residue"
  p e.message
end

begin
  
  @saleticket_prices=myevent.css('.sale-status').css('.prices').css('span').select{|x|!x.text.include?('€')}.map(&:text).join(' | ') rescue nil
   @ticket_prices=myevent.css('.sale-status').css('.prices').css('span').select{|x|!x.text.include?('€')}.map(&:text).join(' | ') rescue nil

  event.price = @ticket_prices
@status.destroy if !@status.persisted?
rescue => e
  p "sale"
  p e.message
end
end
