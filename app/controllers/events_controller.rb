class EventsController < ApplicationController
    def event
    @event=Event.find_by_elbid(params[:id])
    if !@event
      savethisevent(request.path)
    end
    @event=Event.find_by_elbid(params[:id])

    render :showevent
  end
end
