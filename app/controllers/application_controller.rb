class ApplicationController < ActionController::API
  before_action :set_locale

  protected

  def set_locale
    I18n.locale = request.headers['Accept-Language'] || 'en'
  end
end
