

Rails.application.routes.draw do
  #toutes les routes
  get "api/webshop", to: "welcome#webshop"
  get 'whatson/participate'
  root to: redirect("/#{I18n.default_locale}"), as: :redirected_root
  get "/images/svg/build/icons.976f2e9c0405.svg", to: "welcome#mypic"
 get "/en/search/:typesearch/violin", to: "whatson#mysearch"

 scope "/:locale" do

   get "newsletter", to: "welcome#newsletter"
   get "contact-elbphilharmonie", to: 'welcome#contact'
   get "hire", to: 'welcome#hire'
   get 'u30', to: 'welcome#u30'
   get 'freundeskreis', to: 'welcome#freundeskreis'
   get 'publications', to: "welcome#publications"
   get "ticketing-information", to: "welcome#ticket_info"
   get "coronavirus", to: "welcome#corona"
   get "plaza", to: "welcome#plaza"
   get "tours", to: "welcome#tours"
   get "season", to: "whats#season"
   get "press/:kit", to: "press#kit"
   get "participate", to: "whatson#registrations"
   get "participate/:title/:id", to: "whatson#registration", as: :participateshow
   get "/anmelden/:id", to: "whatson#register", as: :partipateform
   post "anmelden/:id", to:"whatson#registrationsuccessful", as: :registrationok
   get "series/international-mendelssohn-festival/896", to: "whatson#subscription"
   get "book-subscription/:id/#/", to: "whatson#subscriptionorder"
   get "mediatheque/tag/:tag", to: "mediatheque#tag", as: :articlesmediatheque
   get "mediatheque/topics", to: "mediatheque#topics", as: :mediathequetopic
   get "mediatheque/category/:cat", to: "mediatheque#category", as: :categorymediatheque
   get "mediathek/category/:cat", to: "mediatheque#category", as: :categorymediatheque2
   get "twinkle-concerts", to: "welcome#concerts"
   
   get "mediatheque/:title/:id", to: "mediatheque#video", as: :mediathequevideo
   get "mediatheque/:title/:id", to: "mediatheque#stream", as: :stream
   get "mediatheque/:title/:id", to: "mediatheque#podcast", as: :podcast
   get "series/:title/:id", to: "mediatheque#concertseries"
   get "mediatheque/:title/:id", to: "mediatheque#showmediatheque", as: :showmediatheque
   get "search", to: "whatson#mysearchevent", as: :mysearchevent
   get "thehalls", to: "thehalls#index", as: :thehalls
   get "search/:q", to: "whatson#search", as: :searchevent
   get "festivals/:titre/:id", to: "festivals#showfestival", as: :showfestival
   get "search/:typesearch/:q", to: "whatson#searchtypeevent"
   get "/en*ajax/1", to: "whatson#ajax1"
   get "whats-on/:title/:id", to: "events#event", as: :event, constraints: {id:  /\d+/}
   get "mediatheque/tag/:name", to: "mediatheque#mytag", as: :tagblog
   get "whats-on/ticket/:title/:id", to: "whatson#buyticket", as: :buyticket, constraints: {id:  /\d+/}
   get "seat-selection/:id", to: "whatson#seatselection", as: :seatselection, constraints: {id:  /\d+/}
   get "whats-on(/:date)(/*other)ajax/1", to: "whatson#events", constraints:  {:date => /\d{2}-\d{2}-\d{4}/}, as: :myeventsajax

   get "whats-on(/:date)(/*other)", to: "whatson#events", constraints:  {:date => /\d{2}-\d{2}-\d{4}/}, as: :myevents
   post "edit", to: "welcome#editaccount", as: :editmyuser
  root to: 'welcome#index'
  get 'my-data', to: 'welcome#mydata', as: :myaccount
  get "my-data/myorders", to: "welcome#myorders", as: :mypurchases
  get "my-data/my-raffles", to: "welcome#pendingticket", as: :pendingticket
  get "my-data/my-newsletters", to: "welcome#newsletters", as: :newsletters
  get "my-data/my-data", to: "welcome#details", as: :details
  get "my-data/change-email", to: "welcome#changeemail", as: :changeemail
  get "my-data/change-password", to: "welcome#changepassword", as: :changepassword
  post "my-data/disableaccounthint", to: "welcome#disableaccounthint", as: :disableaccounthint
  post "my-data/desactivatecustomeraccount", to: "welcome#desactivatecustomeraccount", as: :desactivatecustomeraccount
  post "desactivate", to: "welcome#desactivate", as: :desactivate
  post "myfavoriteevent", to: "whatson#myfavevent", as: :myfavoriteeventajax
devise_for :users, controllers: { registrations: 'registrations' }

devise_scope :user do
 

  get 'logout', to: 'users/sessions#destroy', as: :logout
  post 'my-data', to: 'users/registrations#create2'
  patch 'my-datauser', to: 'users/registrations#updatenews', as: :updatemyuser
  patch "my-data", to: 'users/registrations#update', as: :updatemyuserinfos
  patch "my-dataemail", to: 'users/registrations#updateemail', as: :updatemyuseremail
  patch "my-datapw", to: 'users/registrations#updatepw', as: :updatemyuserpw
end
get "visit", to: "welcome#visit"
get "mediatheque", to: "mediatheque#index"
       get "*myurl", to: "welcome#sitepage", constraints: lambda { |request| Sitepage.where('url like ?',"%#{request.params['myurl'].gsub('/','%')}%").length > 0 }

end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
