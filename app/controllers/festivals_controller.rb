require "./lib/assets/festival"
class FestivalsController < ApplicationController
    def showfestival
    @festival=Festival.find_by_elbid(params[:id]) #new(description: "")
    raise ActiveRecord::RecordNotFound.new if !@festival
    @festival.description.gsub!(/\r\n?/, "\n")
    @festival.description.gsub!(/\n\n?/, "\n")
  rescue ActiveRecord::RecordNotFound
    savethisfestival(request.path,params[:id])
    @festival=Festival.find_by_elbid(params[:id])
  end
end
