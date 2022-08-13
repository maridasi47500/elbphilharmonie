require "./lib/assets/myevent"

class WhatsonController < ApplicationController
  protect_from_forgery except: [:myfavevent]
  def mysearchevent
    if params[:q]
      redirect_to searchevent_path(q: params[:q])
    end
  end

  def searchtypeevent
        @events=Event.search(params[:q],params[:typesearch])

  end
  def search
    @events=Event.upcoming(params[:q])
    @other=Event.other(params[:q])
    @past=Event.past(params[:q])
  end
  def mysearch
    @events=Event.search(params[:q],params[:typesearch])
  end
  def myfavevent
    @event=Event.find(params[:eventid])
    begin
    current_user.favevents << @event
    rescue ActiveRecord::RecordInvalid
      current_user.favevents.delete(@event)
      
    rescue => e
      p e
        p e.message
      
      end
      if !current_user.favevent_ids.include?(@event.id)
        render :myunsavedevent, formats: [:json], layout: false
      elsif current_user.errors.messages.to_a.length == 0
        render formats: [:json], layout: false
      else 
        render inline: "0", layout: false
      end
  end

  def events
    
    path=params[:other].to_s.split('/')
    
    k=path.tally.select{ |k, v| v > 1 }
    p k
    k = k.keys
    if k.length > 0
    k.each do |l|
    path.delete(l)
        searchdate = DateTime.strptime(l.split('/')[0], '%d-%m-%Y') rescue nil
path.delete(searchdate.to_s) if searchdate
    end
    redirect_to myevents_path(other: path.without('').join('/'), date: params[:date])
    else
    
    @searchdate = DateTime.strptime(params[:date], '%d-%m-%Y') rescue nil
    @tags = Eventcat.findby(params[:other].to_s.split('/').to_a,@searchdate)
    @events=Eventcat.findevents(params[:other].to_s.split('/').to_a,@searchdate)
    p @events
    p params[:other]
   
    if request.path.include?('ajax/1')
      render partial: "event", collection: @events, as: :event
    elsif request.path.include?('crop')
      head :ok, content_type: "text/html"
    else 
      render :events

    end
    end
    
  end

  def subscriptions
  end

  def season
    @highlights=Highlight.seasons
    @genres=Highlight.genres
  end

  def participate
    @projects=Musicproject.myprojects
  end
  def registration
    @project=Musicproject.find(params[:id])
  end
  def registrationsuccessfull
    @project=Musicproject.find(params[:id])
    render layout: false
  end
end
