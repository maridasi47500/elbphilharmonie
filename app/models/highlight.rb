class Highlight < ApplicationRecord
  validates_presence_of :title
  attr_accessor :active
  belongs_to :mylabel
  def recognize
    case ((Rails.application.routes.recognize_path self.url, method: :get)[:action] rescue nil)
    when "showfestival"
    when "events"
      "Buy tickets"
    when "video"
    when "concertseries"
      #if la subscription a des blogs "readmore
      #sinon si la subscription est future et n'a pas de blogs bookt ickets
      #si la subscription n'a pas de dates "subcriptions from $34
      
    when "registrations"
      "Register now"
    else
      "Read more"
    end
  end
  def isavideo?
    ((Rails.application.routes.recognize_path self.url, method: :get)[:action] rescue nil) == "video"
  end
  def self.seasons
    where(category: ["Spotlights","Focus on artists","Festivals","Orchestras in residence"]).group_by {|g|g.category}
  end
  def self.genres
    where(category: "Genres").each_slice(2).to_a
  end
end
