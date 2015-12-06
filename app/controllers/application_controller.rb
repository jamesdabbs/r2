class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Pundit

  before_action :authenticate_user!
  after_action :verify_authorized, except: :index, unless: :devise_controller?
end
