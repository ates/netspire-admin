class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CouchRest::DocumentInvalid, :with => :handle_record_invalid
end
