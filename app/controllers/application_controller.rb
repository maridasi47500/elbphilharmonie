class ApplicationController < ActionController::Base
  def default_url_options
  { locale: I18n.locale }
end
end
